class Cell {
  DateTime start;
  DateTime end;
  Cell({required this.start, required this.end});

  @override
  String toString() {
    return 'Cell{start:$start end:$end}';
  }
}
