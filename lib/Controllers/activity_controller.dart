import 'dart:ui';

import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityController extends GetxController {
  Future<int> getStepsAsync(DateTime from) async {
    await Permission.activityRecognition.request();

    HealthFactory health = HealthFactory();

    var now = DateTime.now();
    var result = 0;
    result =
        await health.getTotalStepsInInterval(from.toUtc(), now.toUtc()) ?? 0;

    return result ?? 0;
  }
}
