import 'package:fantasy_odyssey/Persistence/storage_service.dart';
import 'package:get/get.dart';

import '../Models/player_progress.dart';
import '../Models/saved_steps.dart';

class Cache extends GetxService {
  SavedSteps? _savedSteps;
  double? _stepsLength;
  PlayerProgress? _progress;

  final StorageService _storage = Get.find();

  SavedSteps getSavedSteps() {
    _savedSteps ??= _storage.getSavedSteps();

    return _savedSteps!;
  }

  double getStepsLength() {
    _stepsLength ??= _storage.getStepLength();

    return _stepsLength!;
  }

  PlayerProgress getProgress() {
    var savedProgress = _storage.getPlayerProgress();
    if (savedProgress != null) {
      _progress = savedProgress;
    }
    _progress ??= PlayerProgress();

    return _progress!;
  }

  void clearCache() {
    _savedSteps = null;
    _progress = null;
  }

  Future resetProgressAsync() async {
    await _storage.resetProgressAsync();
    _savedSteps = null;
    _progress = null;
  }

  Future saveStepsAsync(SavedSteps stepsToSave) async {
    _savedSteps = stepsToSave;
    await _storage.saveStepsAsync(stepsToSave);
  }

  Future savePlayerProgress(PlayerProgress savedProgress) async {
    _progress = savedProgress;
    await _storage.savePlayerProgressAsync(savedProgress);
  }

  Future saveStepLengthAsync(double stepsLength) async {
    _stepsLength = stepsLength;
    await _storage.saveStepLengthAsync(stepsLength);
  }
}