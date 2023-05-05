import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityController extends GetxController {

  Future<int> getStepsAsync(DateTime from) async {
    await Permission.activityRecognition.request();

    HealthFactory health = HealthFactory();

    var now = DateTime.now();
    var result = await health.getTotalStepsInInterval(from.toUtc(), now.toUtc());

    //TODO fragment do usunięcia
    result = 2000;


    return result ?? 0;
  }
}