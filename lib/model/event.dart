import 'package:flutter/material.dart';

class Event {
  String id;
  String title;
  String description;
  DateTime start;
  DateTime end;
  Color color;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.start,
    required this.end,
    required this.color,
  });

  @override
  String toString() {
    return title;
  }
}


