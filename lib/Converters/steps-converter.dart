import 'package:fantasy_odyssey/Persistence/storage.dart';

class StepsConverter {
  final kmPerStep;
  var storage = Storage();

  StepsConverter(this.kmPerStep);

  double toKm(int steps) {
    var km = steps * kmPerStep;
    return double.parse(km.toStringAsFixed(2));
  }
}