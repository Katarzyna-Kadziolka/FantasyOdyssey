import 'package:fantasy_odyssey/Models/phase.dart';

class PhasesProgress {
  final Map<DateTime, List<int>> progress;
  final Phase phase;

  PhasesProgress(this.phase, this.progress);
}