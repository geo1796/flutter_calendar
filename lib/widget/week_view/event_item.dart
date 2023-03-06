import 'package:flutter/material.dart';
import 'package:flutter_calendar/model/event.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.width, required this.event});
  final double width;
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        color: event.color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          event.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
