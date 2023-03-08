import 'package:flutter/material.dart';
import 'package:flutter_calendar/util/date_util.dart';
import '../../util/week_day.dart';
import '../../model/day.dart';

class WeekDayHeader extends StatelessWidget {
  const WeekDayHeader({super.key, required this.day});
  final Day day;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(color: theme.primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day.weekDay.helper.name,
              style: TextStyle(color: theme.secondaryHeaderColor)),
          Text(formatFR(day.date),
              style: TextStyle(color: theme.secondaryHeaderColor)),
        ],
      ),
    );
  }
}
