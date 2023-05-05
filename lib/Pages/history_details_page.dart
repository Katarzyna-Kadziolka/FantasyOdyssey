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
            children: <Widget>[
              for (var event in events)
                Text(
                  event.distance.toString(),
                  style:
                      const TextStyle(color: Color(0xFFE0F2F1), fontSize: 20),
                )
            ],
          )),
    );
  }
}
