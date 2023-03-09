import 'package:intl/intl.dart';

import '../model/cell.dart';
import '../model/day.dart';
import 'week_day.dart';

enum View { month, week }

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

DateTime getStartOfWeek(DateTime date) {
  final int weekday = date.weekday;
  final DateTime start = date.subtract(Duration(days: weekday - 1));
  return DateTime(start.year, start.month, start.day);
}

DateTime getEndOfWeek(DateTime date) {
  final int daysUntilSunday = 7 - date.weekday;
  final DateTime end = date.add(Duration(days: daysUntilSunday));
  return DateTime(end.year, end.month, end.day, 23, 59, 59, 999);
}

DateTime getStartOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getEndOfMonth(DateTime date) {
  final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
  return DateTime(date.year, date.month, lastDayOfMonth.day);
}

DateTime getStartOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

DateTime getEndOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
}

List<Day> getDays(DateTime date) {
  List<Day> days = [];
  date = getStartOfWeek(date);
  for (int i = 0; i < 7; i++) {
    days.add(Day(weekDay: getWeekDayFromIndex(i), date: date));
    date = getNextDay(date);
  }
  return days;
}

String formatFR(DateTime date) {
  final dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(date);
}

List<Cell> getCells(DateTime date) {
  List<Cell> cells = [];
  final startOfWeek = getStartOfWeek(date);
  date = startOfWeek;
  for (int y = 0; y < 48; y++) {
    for (int i = 0; i < 7; i++) {
      cells.add(Cell(
          start: date.add(Duration(minutes: y * 30)),
          end: date.add(Duration(minutes: (y + 1) * 30))));
      date = getNextDay(date);
    }
    date = startOfWeek;
  }
  return cells;
}

List<Cell> getAllDayCells(DateTime date) {
  List<Cell> cells = [];
  date = getStartOfWeek(date);
  for (int i = 0; i < 7; i++) {
    cells.add(Cell(start: date, end: getEndOfDay(date)));
    date = getNextDay(date);
  }
  return cells;
}

DateTime getNextDay(DateTime date) {
  return getStartOfDay(date.add(const Duration(days: 1)));
}

DateTime getNextWeek(DateTime date) {
  return getStartOfDay(date.add(const Duration(days: 7)));
}

DateTime getLastWeek(DateTime date) {
  return getStartOfDay(date.add(const Duration(days: -7)));
}

Month getMonth(DateTime date) {
  switch (date.month) {
    case 1:
      return Month.january;
    case 2:
      return Month.february;
    case 3:
      return Month.march;
    case 4:
      return Month.april;
    case 5:
      return Month.may;
    case 6:
      return Month.june;
    case 7:
      return Month.july;
    case 8:
      return Month.august;
    case 9:
      return Month.september;
    case 10:
      return Month.october;
    case 11:
      return Month.november;
    case 12:
      return Month.december;
  }
  throw Exception('wrong value');
}

WeekDay getWeekDayFromIndex(int i) {
  switch (i) {
    case 0:
      return WeekDay.monday;
    case 1:
      return WeekDay.tuesday;
    case 2:
      return WeekDay.wednesday;
    case 3:
      return WeekDay.thursday;
    case 4:
      return WeekDay.friday;
    case 5:
      return WeekDay.saturday;
    case 6:
      return WeekDay.sunday;
  }
  throw Exception('wrong value');
}

WeekDay getWeekDayFromDate(DateTime date) {
  final startOfWeek = getStartOfWeek(date);
  final diff = date.difference(startOfWeek);
  return getWeekDayFromIndex(diff.inDays);
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

bool isSameWeek(DateTime date1, DateTime date2) {
  return getStartOfWeek(date1).isAtSameMomentAs(getStartOfWeek(date2));
}

bool inBetween(DateTime between, DateTime date1, DateTime date2) {
  return between.isAfter(date1) && between.isBefore(date2);
}
