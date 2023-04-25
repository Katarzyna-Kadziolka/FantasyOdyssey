import 'package:fantasy_odyssey/Controllers/activity_controller.dart';
import 'package:fantasy_odyssey/Controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final activityController = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: Center(child: Obx(() {
        if (loginController.googleAccount.value == null) return buildLoginButton();
        return buildSummaryPage();
      })),
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        loginController.login();
      },
      icon: Image.asset(
        'images/google_logo.png',
        height: 32,
        width: 32,
      ),
      label: const Text('Sign in with Google'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  Column buildSummaryPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(loginController.googleAccount.value?.photoUrl ?? '')
                  .image,
          radius: 100,
        ),
        Text(
          loginController.googleAccount.value?.displayName ?? '',
          style: Get.textTheme.headlineSmall,
        ),
        Text(
          loginController.googleAccount.value?.email ?? '',
          style: Get.textTheme.bodySmall,
        ),
        ElevatedButton(onPressed: () => activityController.getSteps(), child: const Text('Connect to Google Fit'))
      ],
    );
  }
}