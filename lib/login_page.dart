import 'package:fantasy_odyssey/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

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
        ElevatedButton(onPressed: _connectToGoogleFit, child: const Text('Connect to Google Fit'))
      ],
    );
  }

  void _connectToGoogleFit () async{
    await Permission.activityRecognition.request();
    // create a HealthFactory for use in the app
    HealthFactory health = HealthFactory();

    // define the types to get
    var types = [
      HealthDataType.STEPS,
    ];

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();
    var steps2 = await health.getTotalStepsInInterval(now.subtract(Duration(days: 1)), now);


    // fetch health data from the last 24 hours
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        now.subtract(Duration(days: 1)), now, types);

    // request permissions to write steps and blood glucose
    types = [HealthDataType.STEPS, HealthDataType.BLOOD_GLUCOSE];
    var permissions = [
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE
    ];
    await health.requestAuthorization(types, permissions: permissions);

    // write steps and blood glucose
    bool success = await health.writeHealthData(10, HealthDataType.STEPS, now, now);
    success = await health.writeHealthData(3.1, HealthDataType.BLOOD_GLUCOSE, now, now);

    // get the number of steps for today
    var midnight = DateTime(now.year, now.month, now.day);
    int? steps = await health.getTotalStepsInInterval(midnight, now);
  }
}
