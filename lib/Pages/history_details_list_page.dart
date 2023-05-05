import 'package:fantasy_odyssey/Models/phases_progress.dart';
import 'package:fantasy_odyssey/Pages/history_details_page.dart';
import 'package:flutter/material.dart';

import '../Models/Events/events.dart';
import '../Models/history_event.dart';

class HistoryDetailsListPage extends StatelessWidget {
  const HistoryDetailsListPage({Key? key}) : super(key: key);

  static const routeName = '/historyDetailsList';

  @override
  Widget build(BuildContext context) {
    final phaseProgress =
        ModalRoute.of(context)!.settings.arguments as PhasesProgress;
    var days = phaseProgress.progress.keys.toSet().toList();

    return Scaffold(
      body: Container(
        color: const Color(0xFF121212),
        child: Center(
          child: TextButtonTheme(
            data: TextButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => const Color(0xFF00695C)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(
                      color: Color(0xFF3c4038),
                    ),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width - 20, 40),
                ),
              ),
            ),
              child: ListView(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top:50, bottom: 25),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(
                      phaseProgress.phase,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color(0xFFE0F2F1),
                      ),
                    ),
                  ),
                  for (var date in days)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            HistoryDetailsPage.routeName,
                            arguments: getEvents(phaseProgress.progress[date]!),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${date.day}.${date.month}.${date.year}",
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
        ),
    );
  }

  List<HistoryEvent> getEvents(List<int> indexes) {
    var allEvents = Events().events;
    var filteredEvents = List<HistoryEvent>.empty(growable: true);
    for (var i = 0; i < allEvents.length; i++) {
      if (indexes.contains(i)) {
        var event = allEvents[i];
        filteredEvents.add(event);
      }
    }
    return filteredEvents;
  }
}
