import 'package:fantasy_odyssey/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: Center(child: Obx(() {
        if (controller.googleAccount.value == null) return buildLoginButton();
        return buildSummaryPage();
      })),
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.login();
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
              Image.network(controller.googleAccount.value?.photoUrl ?? '')
                  .image,
          radius: 100,
        ),
        Text(
          controller.googleAccount.value?.displayName ?? '',
          style: Get.textTheme.headlineSmall,
        ),
        Text(
          controller.googleAccount.value?.email ?? '',
          style: Get.textTheme.bodySmall,
        ),
      ],
    );
  }
}
