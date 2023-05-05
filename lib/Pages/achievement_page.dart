import 'dart:collection';

import 'package:flutter/material.dart';

import '../Models/history_event.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({Key? key}) : super(key: key);

  static const routeName = '/achievement';

  @override
  Widget build(BuildContext context) {
    final events = ModalRoute.of(context)!.settings.arguments as Queue<HistoryEvent>;
    var event = events.removeFirst();
    nextEvent() {
      if(events.isNotEmpty) {
        event = events.removeFirst();
      }
      else {
        Navigator.pop(context);
      }
    }


    return Container(
      color: const Color(0xFF121212),
      child: Column(
        children: [
          Text(event.distance.toString()),
          ElevatedButton(onPressed: nextEvent(), child: Text("Next..."))
        ],
      ),
    );
  }
}
