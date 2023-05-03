import 'dart:convert';

import 'package:fantasy_odyssey/Models/saved_steps.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/player_progress.dart';


 class StorageService extends GetxService {
   late SharedPreferences _prefs;

   Future<StorageService> init() async {
     _prefs = await SharedPreferences.getInstance();
     return this;
   }

   SavedSteps getSavedSteps() {
     var steps = _prefs.getInt('steps') ?? 0;
     var timeToConvert = _prefs.getInt( 'updateTime');

     DateTime? updateTime;
     if(timeToConvert != null) {
       updateTime = DateTime.fromMillisecondsSinceEpoch(timeToConvert);
     }

     return SavedSteps(updateTime, steps);
  }

  Future<SavedSteps> saveStepsAsync(SavedSteps savedSteps) async {
    await _prefs.setInt('steps', savedSteps.steps);
    await _prefs.setInt('updateTime', savedSteps.updateTime!.millisecondsSinceEpoch);
    return savedSteps;
  }

  Future resetStepsAsync() async {
     await _prefs.remove('steps');
     await _prefs.remove('updateTime');
  }

  double getStepLength() {
    return _prefs.getDouble('stepLength') ?? 0.00075;
  }

  Future saveStepLengthAsync(double stepLength) async {
    await _prefs.setDouble('stepLength', stepLength);
  }

  PlayerProgress? getProgress() {
     var json = _prefs.getString('progress');
     PlayerProgress? progress;
     if(json != null) {
      progress = PlayerProgress.fromJson(jsonDecode(json));
     }

     return progress;
  }

  Future saveProgressAsync(Progress progress) async {
     var json = jsonEncode(progress);

     await _prefs.setString('progress', json);
  }

}