import 'package:flutter/material.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:flutter_calendar/util/week_day.dart';

import '../../model/event.dart';
import '../../util/date_util.dart';

class AllDayEvents extends StatelessWidget {
  const AllDayEvents({super.key, required this.events});
  final List<Event> events;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrainst) {
      final dayWidth = constrainst.maxWidth / 7.0;
      return Stack(
        children: List.generate(events.length, (i) {
          final e = events[i];
          var top = 0.0;
          var bottom = 0.0;
          final left = getWeekDayFromDate(e.start).helper.index * dayWidth +
              (e.start.hour / 24.0) * dayWidth +
              (e.start.minute / (60.0 * 24.0)) * dayWidth;
          final duration = e.end.difference(e.start);
          final width = (duration.inMinutes / (60.0 * 24.0)) * dayWidth;
          if (events.length % 2 == 0) {
            top = (cellHeight / 2) * i;
            bottom = (cellHeight / 2) * (events.length - (i + 1));
          } else {
            top = (cellHeight / (events.length - (events.length - 2))) * i;
            bottom = (cellHeight / (events.length - (events.length - 2))) *
                (events.length - (i + 1));
          }
          return Positioned(
            top: top,
            bottom: bottom,
            left: left,
            width: width,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                color: e.color,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(e.title),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
