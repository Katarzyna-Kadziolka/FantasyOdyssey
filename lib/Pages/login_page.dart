import 'package:fantasy_odyssey/Controllers/activity_controller.dart';
import 'package:fantasy_odyssey/Controllers/login_controller.dart';
import 'package:fantasy_odyssey/Pages/NavPages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final activityController = Get.put(ActivityController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Fantasy Odyssey'),
        backgroundColor: const Color(0xFF00695C),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/BagEndToRivendel.png"),
              fit: BoxFit.cover),
        ),
        alignment: Alignment.bottomCenter,
        child: Center(
            child: FloatingActionButton.extended(
          onPressed: () {
            loginController.login().then(
                  (_) => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    ),
                  },
                ).catchError((e) {
                  if (e is PlatformException) {
                    var snackBar = SnackBar(content: Text("Error during login: ${e.code} - ${e.message} - ${e.details}"), backgroundColor: Colors.redAccent,);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
            });
          },
          icon: Image.asset(
            'images/google_logo.png',
            height: 32,
            width: 32,
          ),
          label: const Text('Sign in with Google'),
          backgroundColor: const Color(0xFF3c4038),
          foregroundColor: const Color(0xFFE0F2F1),
        )),
      ),
    );
  }
}
