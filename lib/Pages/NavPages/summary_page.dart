import 'package:fantasy_odyssey/Converters/steps-converter.dart';
import 'package:fantasy_odyssey/Models/phase.dart';
import 'package:fantasy_odyssey/Models/saved_steps.dart';
import 'package:fantasy_odyssey/Pages/achievement_page.dart';
import 'package:fantasy_odyssey/Persistence/cache.dart';
import 'package:fantasy_odyssey/Persistence/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import '../../Controllers/activity_controller.dart';
import '../../Models/Events/events.dart';
import '../../Models/history_event.dart';
import '../../Models/player_progress.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final _activityController = Get.put(ActivityController());
  final Cache _cache = Get.find();
  final StorageService _storage = Get.find();

  SavedSteps _savedSteps = SavedSteps(DateTime.now(), 0);
  var _currentPhase = "";
  var _currentPhaseProgress = "";
  var _nextEventText = "";
  final SavedSteps _todaySteps = SavedSteps(
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    0,
  );

  double _todayKm = 0;


  @override
  initState() {
    super.initState();
    final stepLength = _cache.getStepsLength();
    Get.put(StepsConverter(stepLength));
    final savedSteps = _cache.getSavedSteps();
    _handleStepChanged(savedSteps);
  }

  Future _handleStepChanged(SavedSteps savedSteps) async {
    int steps;
    SavedSteps stepsToSave;
    if (savedSteps.updateTime == null) {
      stepsToSave = SavedSteps(DateTime.now(), 0);
      steps = 0;
    } else {
      steps = await _activityController.getStepsAsync(savedSteps.updateTime!);
      stepsToSave =
          SavedSteps(_savedSteps.updateTime!, _savedSteps.steps + steps);
    }
    await _storage.saveStepsAsync(stepsToSave);
    setState(() {
      _savedSteps = stepsToSave;
      _todaySteps.steps = steps;
      _todayKm = Get.find<StepsConverter>().toKm(steps);
      var lastEvent = Events()
          .events
          .lastWhereOrNull((element) => element.distance < Get.find<StepsConverter>().toKm(steps));
      _currentPhase = lastEvent?.phase?.text ?? Phase.bagEndToRivendell.text;
      _currentPhaseProgress = getCurrentPhaseProgress(steps);
      _nextEventText = getNextEventText(steps);
    });
    await handleProgressChanged(_savedSteps.steps + steps).then((value) => {
          if (value.isNotEmpty)
            Navigator.pushNamed(
              context,
              AchievementPage.routeName,
              arguments: value,
            )
        });
  }

  String getNextEventText(int totalSteps) {
    var allEvents = Events().events;
    var totalKm = Get.find<StepsConverter>().toKm(totalSteps);
    var nextEvent = allEvents.firstWhere((element) => element.distance > totalKm);
    var distanceToNextEvent = nextEvent.distance - totalKm;
    return "Next: ${distanceToNextEvent.toStringAsFixed(2)} km";
  }


  String getCurrentPhaseProgress(int totalSteps) {
    var allEvents = Events().events;
    var totalKm = Get.find<StepsConverter>().toKm(totalSteps);
    var currentPhase =
        allEvents.lastWhereOrNull((element) => element.distance < totalKm)?.phase ?? Phase.bagEndToRivendell;
    var currentPhaseIndex = Phase.values.indexOf(currentPhase);
    double distanceToLastPhaseLastEvent = 0;
    if (currentPhaseIndex != 0) {
      var lastPhase = Phase.values[currentPhaseIndex - 1];
      distanceToLastPhaseLastEvent = allEvents
          .lastWhere((element) => element.phase == lastPhase)
          .distance;
    }
    var currentKmInPhase = totalKm - distanceToLastPhaseLastEvent;
    var kmToEndOfPhase = allEvents
            .lastWhere((element) => element.phase == currentPhase)
            .distance -
        allEvents
            .firstWhere((element) => element.phase == currentPhase)
            .distance;
    return "Total: ${currentKmInPhase.toStringAsFixed(2)} km (${((currentKmInPhase * 100) / kmToEndOfPhase).toStringAsFixed(2)}%)";
  }

  Future<List<HistoryEvent>> handleProgressChanged(int steps) async {
    var savedProgress = _storage.getPlayerProgress();
    savedProgress ??= PlayerProgress();
    double kmLastEvent = 0;
    var allEvents = Events().events;
    if (savedProgress.progress.isNotEmpty) {
      var lastPhase = savedProgress.progress.keys.last;
      var lastDate = savedProgress.progress[lastPhase]!.keys.last;
      var lastIndex = savedProgress.progress[lastPhase]![lastDate]!.last;
      kmLastEvent = allEvents[lastIndex].distance;
    }
    StepsConverter converter = Get.find();
    var newFullKm = converter.toKm(steps);
    var oldEvents =
        allEvents.where((element) => element.distance <= kmLastEvent);
    var newEvents = allEvents.where((element) => element.distance <= newFullKm);
    var eventsToDisplay = newEvents
        .where((element) => oldEvents.every((x) => x != element))
        .toList();
    var grouped = groupBy(eventsToDisplay, (x) => x.phase);
    grouped.forEach((phase, events) {
      var eventsToAdd = events
          .map((e) =>
              allEvents.indexWhere((element) => element.distance == e.distance))
          .toList();
      if (savedProgress!.progress.containsKey(phase)) {
        savedProgress.progress[phase]!
            .addAll({DateUtils.dateOnly(DateTime.now()): eventsToAdd});
      } else {
        savedProgress.progress[phase] = {
          DateUtils.dateOnly(DateTime.now()): eventsToAdd
        };
      }
    });
    await _storage.savePlayerProgressAsync(savedProgress);
    return eventsToDisplay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/BagEndToRivendel.png"),
            fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 250,
        width: 250,
        margin: const EdgeInsets.only(bottom: 50),
        child: Card(
          color: const Color(0xFF00695C).withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: DefaultTextStyle(
            style: const TextStyle(color: Color(0xFFE0F2F1)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _currentPhase,
                    style: TextStyle(fontSize: 22),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${_todaySteps.steps.toString()} steps",
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        "$_todayKm km",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  Text(
                    _currentPhaseProgress,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    _nextEventText,
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
