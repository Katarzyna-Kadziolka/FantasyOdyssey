import 'package:fantasy_odyssey/Models/saved_steps.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class Storage {
   late SharedPreferences _prefs;

   Storage() {
     _initSharedPreferences();
   }

   Future<void> _initSharedPreferences() async {
     _prefs = await SharedPreferences.getInstance();
   }

   Future<SavedSteps> getSavedStepsAsync() async {
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

  Future resetSteps() async {
     await _prefs.remove('steps');
     await _prefs.remove('updateTime');
  }

  Future<double> getStepLengthAsync() async {
    return _prefs.getDouble('stepLength') ?? 0.00075;
  }

  Future saveStepLengthAsync(double stepLength) async {
    await _prefs.setDouble('stepLength', stepLength);
  }

  // Future<List<List<string>>> getProgress() async {
  //    var progress = _prefs.getStringList(key)
  // }

}