import 'package:flutter/material.dart';
import 'package:flutter_calendar/widget/week_view/week_day_stack.dart';

class WeekViewEvents extends StatelessWidget {
  const WeekViewEvents({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final dayWidth = constraints.maxWidth / 7;
      return WeekDayStack(totalWidth: constraints.maxWidth, dayWidth: dayWidth);
    });
  }
}
