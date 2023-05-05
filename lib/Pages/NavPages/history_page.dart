import 'package:fantasy_odyssey/Models/phase.dart';
import 'package:fantasy_odyssey/Models/phases_progress.dart';
import 'package:fantasy_odyssey/Models/player_progress.dart';
import 'package:fantasy_odyssey/Pages/history_details_list_page.dart';
import 'package:fantasy_odyssey/Persistence/cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _phaseNames = Phase.values.map((e) => e.text).toList();
  final Cache _cache = Get.find();
  PlayerProgress _progress = PlayerProgress();

  @override
  void initState() {
    super.initState();
    _progress = _cache.getProgress();
  }

  @override
  Widget build(BuildContext context) {
    var unlockedButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
              (states) => const Color(0xFF302c2c)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(
            color: Color(0xFF3c4038),
          ),
        ),
      ),
      minimumSize: MaterialStateProperty.all(
        Size(MediaQuery
            .of(context)
            .size
            .width - 20, 40),
      ),
    );
    var lockedButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
              (states) => const Color(0xFF302c2c).withOpacity(0.3)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(
            color: Color(0xFF3c4038),
          ),
        ),
      ),
      minimumSize: MaterialStateProperty.all(
        Size(MediaQuery
            .of(context)
            .size
            .width - 20, 40),
      ),
    );
    return Container(
      color: const Color(0xFF121212),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (var phaseName in _phaseNames)
                ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                      style: getProgressForPhase(phaseName) == null
                          ? lockedButton
                          : unlockedButton),
                  child: ElevatedButton(
                    onPressed: getProgressForPhase(phaseName) == null
                        ? null
                        : () =>
                    {
                      Navigator.pushNamed(
                        context,
                        HistoryDetailsListPage.routeName,
                        arguments: PhasesProgress(
                          phaseName,
                          getProgressForPhase(phaseName) ?? {},
                        ),
                      )
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        phaseName,
                        style: const TextStyle(
                            color: Color(0xFFE0F2F1), fontSize: 20),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Map<DateTime, List<int>>? getProgressForPhase(String phaseName) =>
      _progress.progress[
      Phase.values.firstWhere((element) => element.text == phaseName)];
}
