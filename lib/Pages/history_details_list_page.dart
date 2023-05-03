import 'package:fantasy_odyssey/Models/phases_progress.dart';
import 'package:flutter/material.dart';

class HistoryDetailsListPage extends StatelessWidget {
  const HistoryDetailsListPage({Key? key}) : super(key: key);

  static const routeName = '/historyDetailsList';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PhasesProgress;
    var days = args.progress.keys.map((date) => "${date.day}.${date.month}.${date.year}").toSet().toList();

    return Container(
      color: const Color(0xFF121212),
      child: Center(
        child: TextButtonTheme(
          data: TextButtonThemeData(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Text(args.phase),
                for(var day in days) TextButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      day,
                      style: const TextStyle(color: Color(0xFFE0F2F1), fontSize: 20),
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
}
