enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class WeekDayHelper {
  final String name;
  final int index;
  const WeekDayHelper(this.name, this.index);
}

extension WeekDayExtenstion on WeekDay {
  WeekDayHelper get helper {
    switch (this) {
      case WeekDay.monday: return const WeekDayHelper('Lundi', 0);
      case WeekDay.tuesday: return const WeekDayHelper('Mardi', 1);
      case WeekDay.wednesday: return const WeekDayHelper('Mercredi', 2);
      case WeekDay.thursday: return const WeekDayHelper('Jeudi', 3);
      case WeekDay.friday: return const WeekDayHelper('Vendredi', 4);
      case WeekDay.saturday: return const WeekDayHelper('Samedi', 5);
      case WeekDay.sunday: return const WeekDayHelper('Dimanche', 6);
      default: throw Exception('wrong value');
    }
  }
}