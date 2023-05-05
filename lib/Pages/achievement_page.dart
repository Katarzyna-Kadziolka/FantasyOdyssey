
import 'package:flutter/material.dart';

import '../Models/history_event.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({Key? key}) : super(key: key);
  static const routeName = '/achievement';

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  var currentIndex = 0;
  late HistoryEvent event;
  late List<HistoryEvent> events;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    events = ModalRoute.of(context)!.settings.arguments as List<HistoryEvent>;
    event = events[currentIndex];
    return Container(
      color: const Color(0xFF121212),
      child: ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: ButtonStyle(
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
              Size(MediaQuery.of(context).size.width - 20, 40),
            ),
          ),
        ),
        child: Column(
          children: [
            Text(event.distance.toString()),
            ElevatedButton(onPressed: () {
              if (currentIndex < events.length - 1) {
                currentIndex++;
                setState(() {
                  event = events[currentIndex];
                });
              } else {
                Navigator.pop(context);
              }
            }, child: Text("Next..."))
          ],
        ),
      ),
    );
  }
}




