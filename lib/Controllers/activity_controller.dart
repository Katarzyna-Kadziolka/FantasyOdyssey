import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityController extends GetxController {

  Future<int> getStepsAsync(DateTime from) async {
    await Permission.activityRecognition.request();

    HealthFactory health = HealthFactory();

    var types = [
      HealthDataType.STEPS,
    ];

    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();
    var result = await health.getTotalStepsInInterval(from.toUtc(), now.toUtc());
    return result ?? 0;
  }
}