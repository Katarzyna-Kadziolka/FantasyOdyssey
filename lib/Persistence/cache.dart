import 'package:fantasy_odyssey/Persistence/storage.dart';

import '../Models/progress.dart';
import '../Models/saved_steps.dart';

class Cache {
  SavedSteps? _savedSteps;
  double? _stepsLength;
  Progress? _progress;

  final _storage = Storage();

  SavedSteps getSavedSteps() {
    _savedSteps ??= _storage.getSavedSteps();

    return _savedSteps!;
  }

  double getStepsLength() {
    _stepsLength ??= _storage.getStepLength();

    return _stepsLength!;
  }

  Progress getProgress() {
    _progress ??= _storage.getProgress();

    return _progress!;
  }
}