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
                        "3200 steps",
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
