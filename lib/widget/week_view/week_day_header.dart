import 'package:flutter/material.dart';
import 'package:flutter_calendar/util/date_util.dart';
import '../../util/week_day.dart';
import '../../model/day.dart';

class WeekDayHeader extends StatelessWidget {
  const WeekDayHeader({super.key, required this.day});
  final Day day;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Center(
          child: Column(
        children: [
          Text(day.weekDay.helper.name),
          Text(formatFR(day.date)),
        ],
      )),
    );
  }
}
