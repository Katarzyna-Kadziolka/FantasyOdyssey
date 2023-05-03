import 'package:fantasy_odyssey/Persistence/storage_service.dart';

class StepsConverter {
  final kmPerStep;

  StepsConverter(this.kmPerStep);

  double toKm(int steps) {
    var km = steps * kmPerStep;
    return double.parse(km.toStringAsFixed(2));
  }
}