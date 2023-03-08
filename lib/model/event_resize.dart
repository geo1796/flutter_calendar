import 'package:flutter_calendar/model/event.dart';

enum ResizeType { start, end }

class EventResize {
  final Event event;
  final ResizeType type;

  EventResize(this.event, this.type);
}