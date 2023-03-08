import 'dart:math';

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
    Event(
      id: '5',
      title: 'event5',
      description: 'the fifth event',
      start: DateTime.now().add(const Duration(hours: -1)),
      end: DateTime.now().add(const Duration(hours: 2)),
      color: Colors.brown,
    ),
    Event(
      id: '6',
      title: 'event6',
      description: 'the sixth event',
      start: DateTime.now().add(const Duration()),
      end: DateTime.now().add(const Duration(minutes: 30)),
      color: Colors.purple,
    ),
    Event(
      id: '7',
      title: 'event7',
      description: 'the seventh event',
      start: DateTime.now().add(const Duration()),
      end: DateTime.now().add(const Duration(minutes: 45)),
      color: Colors.pink,
    ),
    Event(
      id: '8',
      title: 'event8',
      description: 'the eigth event',
      start: DateTime.now().add(const Duration()),
      end: DateTime.now().add(const Duration(minutes: 45)),
      color: Colors.amber,
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

  void updateDrag(Event event, DateTime newStart) {
    final duration = event.end.difference(event.start);
    event.start = newStart;
    event.end = newStart.add(duration);
    events.removeWhere((e) => e.id == event.id);
    events.add(event);
  }

  void updateResizeStart(Event event, DateTime newStart) {
    if (newStart.isAfter(event.end) || newStart.isAtSameMomentAs(event.end)) {
      return;
    }
    event.start = newStart;
    events.removeWhere((e) => e.id == event.id);
    events.add(event);
  }

  void updateResizeEnd(Event event, DateTime newEnd) {
    if (newEnd.isBefore(event.start) || newEnd.isAtSameMomentAs(event.start)) {
      return;
    }
    event.end = newEnd;
    events.removeWhere((e) => e.id == event.id);
    events.add(event);
  }
}