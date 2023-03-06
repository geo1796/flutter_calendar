import 'package:flutter/material.dart';
import 'package:flutter_calendar/model/cell.dart';
import 'package:get/get.dart';

import '../model/day.dart';
import '../model/event.dart';
import '../util/date_util.dart';

class AgendaController extends RxController {
  var view = View.week.obs;
  var date = DateTime.now().obs;
  var dragging = false.obs;
  var events = [
    Event(
      id: '1',
      title: 'event1',
      description: 'the first event',
      start: DateTime.now().add(const Duration(hours: -1)),
      end: DateTime.now().add(const Duration(hours: 2)),
      color: Colors.blue,
    ),
    Event(
      id: '2',
      title: 'event2',
      description: 'the second event',
      start: DateTime.now().add(const Duration()),
      end: DateTime.now().add(const Duration(minutes: 30)),
      color: Colors.red,
    ),
    Event(
      id: '3',
      title: 'event3',
      description: 'the third event',
      start: DateTime.now().add(const Duration()),
      end: DateTime.now().add(const Duration(minutes: 45)),
      color: Colors.yellow,
    ),
    Event(
      id: '4',
      title: 'event4',
      description: 'the fourth event',
      start: DateTime.now().add(const Duration()),
      end: DateTime.now().add(const Duration(minutes: 45)),
      color: Colors.green,
    ),
  ].obs;

  List<Event> getEventsByCell(Cell cell) {
    return events
        .where((e) =>
            cell.start.isAtSameMomentAs(e.start) ||
            (cell.start.isBefore(e.start) && cell.end.isAfter(e.start)))
        .toList();
  }

  List<Event> getEventsByDay(Day day) {
    return events
        .where(
            (e) => isSameDay(e.start, day.date) || isSameDay(e.end, day.date))
        .toList();
  }

  List<Event> getEventsByWeek(DateTime date) {
    return events
        .where((e) => isSameWeek(e.start, date) || isSameWeek(e.end, date))
        .toList();
  }

  void updateEvent(Event event, DateTime newStart) {
    event = events.firstWhere((e) => e.id == event.id);
    final duration = event.end.difference(event.start);
    event.start = newStart;
    event.end = newStart.add(duration);
    events.removeWhere((e) => e.id == event.id);
    events.add(event);
  }
}
