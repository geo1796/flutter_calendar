import 'package:flutter/material.dart';
import 'package:flutter_calendar/model/cell.dart';
import 'package:flutter_calendar/widget/week_view/drag_target_cell.dart';
import 'package:flutter_calendar/widget/week_view/resize_target_cell.dart';

class CellItem extends StatelessWidget {
  const CellItem({super.key, required this.cell});
  final Cell cell;
  @override
  Widget build(BuildContext context) {
    // return DragTargetCell(cell: cell);
    return Stack(
      children: [
        ResizeTargetCell(cell: cell),
        DragTargetCell(cell: cell),
      ],
    );
  }
}
