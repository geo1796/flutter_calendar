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

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.start,
    required this.end,
    required this.color,
    bool? allDay,
  }) {
    if (allDay != null) {
      this.allDay = allDay;
    } else {
      if (isSameDay(start, end)) {
        this.allDay = false;
      } else {
        this.allDay = true;
      }
    }
  }

  @override
  String toString() {
    return title;
  }
}
