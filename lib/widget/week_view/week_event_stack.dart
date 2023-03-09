import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/controller/layout_controller.dart';
import 'package:flutter_calendar/model/event.dart';
import 'package:flutter_calendar/model/event_position.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:flutter_calendar/util/week_day.dart';
import 'package:flutter_calendar/widget/week_view/event_item.dart';
import 'package:get/get.dart';
import '../../util/date_util.dart';

class WeekEventStack extends StatelessWidget {
  const WeekEventStack(
      {super.key, required this.dayWidth, required this.totalWidth});
  final double dayWidth;
  final double totalWidth;

  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    final LayoutController layoutController = Get.find();
    return Obx(() {
      final events = <Event>[];
      final date = agendaController.date.value;
      for (Event event in agendaController.getEventsByWeek(date)) {
        if (!event.allDay) {
          if (!isSameDay(event.start, event.end)) {
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
      }
      events.sort((e1, e2) {
        final duration1 = e1.end.difference(e1.start);
        final duration2 = e2.end.difference(e2.start);
        return duration1 >= duration2 ? 0 : 1;
      });
    final startHour = agendaController.startHour.value;
    final endHour = agendaController.endHour.value;
      return SizedBox(
        height: layoutController.dayHeigth.value,
        child: Stack(
          children: List.generate(events.length, (i) {
            final e = events[i];
            return EventItem(
                width: dayWidth,
                event: e,
                position: getEventPosition(events, i, startHour, endHour));
          }),
        ),
      );
    });
  }

  EventPosition getEventPosition(List<Event> events, int index, int startHour, int endHour) {
    final currentEvent = events[index];
    final top = ((currentEvent.start.hour - startHour) + currentEvent.start.minute / 60.0) *
        hourHeight;
    var bottom = 0.0;
    if (currentEvent.start.day == currentEvent.end.day) {
      bottom = dayHeight -
          ((currentEvent.end.hour + (endHour%24)) + currentEvent.end.minute / 60.0) * hourHeight;
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
