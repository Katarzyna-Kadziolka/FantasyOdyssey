import 'package:get/get.dart';

import '../Models/history_event.dart';

class EventsController extends GetxController {
  final events = List<HistoryEvent>.empty(growable: true).obs;

  updateEvents(List<HistoryEvent> newEvents) {
    events.clear();
    events.addAll(newEvents);
  }
}