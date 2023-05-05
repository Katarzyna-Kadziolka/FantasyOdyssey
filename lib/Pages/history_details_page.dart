import 'package:flutter/material.dart';

import '../Models/history_event.dart';

class HistoryDetailsPage extends StatelessWidget {
  const HistoryDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/historyDetails';

  @override
  Widget build(BuildContext context) {
    final events =
        ModalRoute.of(context)!.settings.arguments as List<HistoryEvent>;

    return Scaffold(
      body: Container(
        color: const Color(0xFF121212),
        child: ListView(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 50, bottom: 25),
          children: <Widget>[
            for (var event in events)
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00695C),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "${event.distance.toString()} km",
                            style: const TextStyle(
                                color: Color(0xFFE0F2F1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          event.description,
                          style: const TextStyle(
                            color: Color(0xFFE0F2F1),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
