import 'package:fantasy_odyssey/Models/saved_steps.dart';
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
  final storage = Storage();
  SavedSteps _savedSteps = SavedSteps(DateTime.now(), 0);
  final activityController = Get.put(ActivityController());
  @override
  initState () {
    super.initState();
    storage.getSavedStepsAsync().then((value) => _handleStepChanged(value));
  }
  Future _handleStepChanged(SavedSteps savedSteps) async {
    setState(() {
      _savedSteps = savedSteps;
    });

    if(_savedSteps.updateTime == null) {
      storage.saveStepsAsync(SavedSteps(DateTime.now(), 0));
    }
    else {
      var steps = await activityController.getStepsAsync(_savedSteps.updateTime!);
      _savedSteps = await storage.saveStepsAsync(SavedSteps(_savedSteps.updateTime!, _savedSteps.steps + steps));
      setState(() {
        _savedSteps = _savedSteps;
      });
    }
  }

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          ),
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
                      Text(
                        "Today",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "6,8 km",
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        "${_savedSteps.steps.toString()} steps",
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
