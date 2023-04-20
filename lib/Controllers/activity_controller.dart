import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityController extends GetxController {

  getSteps() async {
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
  }
}