import 'package:fantasy_odyssey/Persistence/storage.dart';

import '../Models/phase.dart';
import '../Models/saved_steps.dart';

class StepsCache {
  SavedSteps? _savedSteps;
  double? _stepsLength;
  Map<Phase, Map<DateTime, List<int>>>? _progress;

  final _storage = Storage();

  Future<SavedSteps> getSavedStepsAsync() async {
    _savedSteps ??= await _storage.getSavedStepsAsync();

    return _savedSteps!;
  }

  Future<double> getStepsLengthAsync() async {
    _stepsLength ??= await _storage.getStepLengthAsync();

    return _stepsLength!;
  }

  Future<Map<Phase, Map<DateTime, List<int>>>> getProgressAsync() async {
    _progress ??= await _storage.getProgress();

    return _progress!;
  }
}