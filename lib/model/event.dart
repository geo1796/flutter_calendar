import 'package:flutter/material.dart';
import 'package:flutter_calendar/util/date_util.dart';

class Event {
  String id;
  String title;
  String description;
  DateTime start;
  DateTime end;
  Color color;
  late bool allDay;

  Event(
      {required this.id,
      required this.title,
      required this.description,
      required this.start,
      required this.end,
      required this.color}) {
    if (isSameDay(start, end)) {
      allDay = false;
    } else {
      allDay = true;
    }
  }

  @override
  String toString() {
    return title;
  }
}
