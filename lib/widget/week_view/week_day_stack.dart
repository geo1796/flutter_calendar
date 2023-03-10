import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/model/event.dart';
import 'package:flutter_calendar/model/event_position.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:flutter_calendar/util/week_day.dart';
import 'package:flutter_calendar/widget/week_view/event_item.dart';
import 'package:get/get.dart';
import '../../util/date_util.dart';

class WeekDayStack extends StatelessWidget {
  const WeekDayStack(
      {super.key, required this.dayWidth, required this.totalWidth});
  final double dayWidth;
  final double totalWidth;

  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    return Obx(() {
      final events = <Event>[];
      final date = agendaController.date.value;
      for (Event event in agendaController.getEventsByWeek(date)) {
        if (event.start.day != event.end.day) {
          events.add(Event(
              id: event.id,
              title: event.title,
              description: event.description,
              start: event.start,
              end: getEndOfDay(event.start),
              color: event.color));
          if (isSameWeek(event.end, date)) {
            events.add(Event(
                id: event.id,
                title: event.title,
                description: event.description,
                start: getStartOfDay(event.end),
                end: event.end,
                color: event.color));
          }
        } else {
          events.add(event);
        }
      }
      events.sort((e1, e2) {
        final duration1 = e1.end.difference(e1.start);
        final duration2 = e2.end.difference(e2.start);
        return duration1 >= duration2 ? 0 : 1;
      });
      return SizedBox(
        height: dayHeight,
        child: Stack(
          children: List.generate(events.length, (i) {
            final e = events[i];
            final position = getEventPosition(events, i);
            return Positioned(
              width: position.width,
              top: position.top,
              bottom: position.bottom,
              left: position.left,
              child: IgnorePointer(
                ignoring: agendaController.dragging.value,
                child: Draggable<Event>(
                  onDragStarted: () => agendaController.dragging.value = true,
                  onDragEnd: (_) => agendaController.dragging.value = false,
                  onDragCompleted: () =>
                      agendaController.dragging.value = false,
                  maxSimultaneousDrags: 1,
                  data: e,
                  feedback: Container(),
                  child: EventItem(
                    width: dayWidth,
                    event: e,
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }

  EventPosition getEventPosition(List<Event> events, int index) {
    final currentEvent = events[index];
    final top = (currentEvent.start.hour + currentEvent.start.minute / 60.0) *
        cellHeight;
    var bottom = 0.0;
    if (currentEvent.start.day == currentEvent.end.day) {
      bottom = dayHeight -
          (currentEvent.end.hour + currentEvent.end.minute / 60.0) * cellHeight;
    }
    var left = 0.0;
    var width = 0.0;
    var onTheLeft = 0;
    for (Event event in events.sublist(0, index)) {
      if (inBetween(currentEvent.start, event.start, event.end) ||
          inBetween(event.start, currentEvent.start, currentEvent.end) ||
          currentEvent.start.isAtSameMomentAs(event.start)) {
        onTheLeft++;
      }
    }
    final onSameCell = events
        .where((event) =>
            inBetween(currentEvent.start, event.start, event.end) ||
            inBetween(event.start, currentEvent.start, currentEvent.end) ||
            (currentEvent.start.isAtSameMomentAs(event.start)))
        .length;
    if (onTheLeft == 0) {
      left = getWeekDayFromDate(currentEvent.start).helper.index * dayWidth;
      width = dayWidth;
    } else {
      left = getWeekDayFromDate(currentEvent.start).helper.index * dayWidth +
          (dayWidth * (onTheLeft)) / onSameCell;
      width = dayWidth - dayWidth * onTheLeft / onSameCell;
    }
    return EventPosition(top: top, bottom: bottom, left: left, width: width);
  }
}
