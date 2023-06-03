import 'package:get/get.dart';

class StepsConverter extends GetxService {
  final kmPerStep;

  StepsConverter(this.kmPerStep);

  double toKm(int steps) {
    var km = steps * kmPerStep;
    return double.parse(km.toStringAsFixed(2));
  }
}