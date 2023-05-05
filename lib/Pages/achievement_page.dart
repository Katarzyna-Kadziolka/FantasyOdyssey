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
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/BagEndToRivendel.png"),
              fit: BoxFit.cover),
        ),
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
          child: Center(
            child: ListView(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 50, bottom: 25),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF352f2e),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              "${event.distance.toString()} km",
                              style: const TextStyle(
                                color: Color(0xFFE0F2F1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(event.description, style: const TextStyle(
                            color: Color(0xFFE0F2F1),
                            fontSize: 18,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (currentIndex < events.length - 1) {
                        currentIndex++;
                        setState(() {
                          event = events[currentIndex];
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Next...")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
