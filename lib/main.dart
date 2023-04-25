import 'package:fantasy_odyssey/Controllers/login_controller.dart';
import 'package:fantasy_odyssey/Pages/NavPages/main_page.dart';
import 'package:fantasy_odyssey/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    bool isLoggedIn = loginController.googleAccount.value == null;

    Widget homeScreen = isLoggedIn ? const MainPage() : LoginPage();

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage()
      //home: homeScreen,
    );
  }
}
