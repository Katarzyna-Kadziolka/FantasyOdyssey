import 'package:fantasy_odyssey/Pages/NavPages/setting_page.dart';
import 'package:fantasy_odyssey/Pages/NavPages/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'history_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const SummaryPage(),
    const HistoryPage(),
    const SettingPage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0 ? null : AppBar(
        title: const Text("Fantasy Odyssey"),
        backgroundColor: const Color(0xFF009A45),
        automaticallyImplyLeading: false,
      ),
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          backgroundColor: const Color(0xFF00695C),
          selectedItemColor: const Color(0xFFE0F2F1),
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              label: "Journey",
              icon: Icon(Icons.hiking),
            ),
            BottomNavigationBarItem(
              label: "History",
              icon: Icon(Icons.library_books),
            ),
            BottomNavigationBarItem(
              label: "Setting",
              icon: Icon(Icons.settings),
            ),
          ]),
    );
  }
}
