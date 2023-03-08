import 'package:flutter/material.dart';
import 'package:flutter_calendar/widget/week_view/week_event_stack.dart';

class WeekViewEvents extends StatelessWidget {
  const WeekViewEvents({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final dayWidth = constraints.maxWidth / 7;
      return WeekEventStack(totalWidth: constraints.maxWidth, dayWidth: dayWidth);
    });
  }
}
