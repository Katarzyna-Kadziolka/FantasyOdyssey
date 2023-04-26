import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityController extends GetxController {

  Future<int> getStepsAsync(DateTime lastUpdate) async {
    await Permission.activityRecognition.request();

    HealthFactory health = HealthFactory();

    // define the types to get
    var types = [
      HealthDataType.STEPS,
    ];

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();
    var dateOne = now.subtract(Duration(days: 1));
    var result = await health.getTotalStepsInInterval(lastUpdate.toUtc(), now.toUtc());
    return result ?? 0;
  }
}