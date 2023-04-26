import 'package:fantasy_odyssey/Models/saved_steps.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class Storage {

   Future<SavedSteps> getSavedStepsAsync() async {
     final prefs = await SharedPreferences.getInstance();

     var steps = prefs.getInt('steps') ?? 0;
     var timeToConvert = prefs.getInt( 'updateTime');

     DateTime? updateTime;
     if(timeToConvert != null) {
       updateTime = DateTime.fromMillisecondsSinceEpoch(timeToConvert);
     }

     return SavedSteps(updateTime, steps);
  }

  Future<SavedSteps> saveStepsAsync(SavedSteps savedSteps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps', savedSteps.steps);
    await prefs.setInt('updateTime', savedSteps.updateTime!.millisecondsSinceEpoch);
    return savedSteps;
  }

}