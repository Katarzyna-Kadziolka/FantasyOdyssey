import 'package:fantasy_odyssey/Models/phase.dart';

class HistoryEvent {
  double distance;
  String description;
  Phase phase;

  HistoryEvent(this.phase, this.distance, this.description);
}