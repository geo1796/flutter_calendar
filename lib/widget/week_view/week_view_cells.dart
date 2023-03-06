import 'package:flutter/material.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:flutter_calendar/widget/week_view/cell_item.dart';

import '../../util/date_util.dart';

class WeekViewCells extends StatelessWidget {
  const WeekViewCells({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final cells = getCells(date);
    return LayoutBuilder(builder: (ctx, constraints) {
      final itemWidth = constraints.maxWidth / 7;
      return GridView.builder(
          itemCount: cells.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, childAspectRatio: itemWidth / cellHeight),
          itemBuilder: (ctx, i) => Container(
                decoration: BoxDecoration(border: Border.all()),
                child: CellItem(cell: cells[i]),
              ));
    });
  }
}
