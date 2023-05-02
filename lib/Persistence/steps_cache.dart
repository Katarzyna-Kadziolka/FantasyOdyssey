import 'package:fantasy_odyssey/Persistence/storage.dart';

import '../Models/saved_steps.dart';

class StepsCache {
  SavedSteps? _savedSteps;
  double? _stepsLength;

  final _storage = Storage();

  Future<SavedSteps> getSavedStepsAsync() async {
    _savedSteps ??= await _storage.getSavedStepsAsync();

    return _savedSteps!;
  }

  Future<double> getStepsLengthAsync() async {
    _stepsLength ??= await _storage.getStepLengthAsync();

    return _stepsLength!;
  }
}