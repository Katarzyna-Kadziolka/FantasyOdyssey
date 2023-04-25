import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
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
          child: DefaultTextStyle(
            style: TextStyle(color: Color(0xFFE0F2F1)),
            child: Column (
              children: [
                Text("text1"),
                Text("text2")
              ],
            ),
          ),
        ),
      ),

    );
  }
}
