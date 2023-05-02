import 'package:fantasy_odyssey/Converters/steps-converter.dart';
import 'package:fantasy_odyssey/Models/saved_steps.dart';
import 'package:fantasy_odyssey/Persistence/steps_cache.dart';
import 'package:fantasy_odyssey/Persistence/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/activity_controller.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final _activityController = Get.put(ActivityController());
  final _stepsCache = Get.put(StepsCache());

  final _storage = Storage();

  SavedSteps _savedSteps = SavedSteps(DateTime.now(), 0);
  final SavedSteps _todaySteps = SavedSteps(
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    0,
  );

  double _todayKm = 0;

  @override
  initState() {
    super.initState();
    _stepsCache.getSavedStepsAsync().then((value) => _handleStepChanged(value));
    _stepsCache.getStepsLengthAsync().then((value) => {
      setTodaySteps(value)
    } );

    _activityController
        .getStepsAsync(_todaySteps.updateTime!)
        .then((value) => setState(() {
              _todaySteps.steps = value;
            }));
  }

  setTodaySteps(double stepLength) {
    var converter = StepsConverter(stepLength);
    setState(() {
      _todayKm = converter.toKm(_todaySteps.steps);
    });
  }

  Future _handleStepChanged(SavedSteps savedSteps) async {
    setState(() {
      _savedSteps = savedSteps;
    });

    if (_savedSteps.updateTime == null) {
      _storage.saveStepsAsync(SavedSteps(DateTime.now(), 0));
    } else {
      var steps =
          await _activityController.getStepsAsync(_savedSteps.updateTime!);
      _savedSteps = await _storage.saveStepsAsync(
          SavedSteps(_savedSteps.updateTime!, _savedSteps.steps + steps));
      setState(() {
        _savedSteps = _savedSteps;
      });
    }

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
                    "Bagend to Rivendel",
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
                    "Total: 30 km (6%)",
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
