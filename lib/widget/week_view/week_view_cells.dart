import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:flutter_calendar/widget/week_view/cell_item.dart';
import 'package:get/get.dart';

import '../../util/date_util.dart';

class WeekViewCells extends StatelessWidget {
  const WeekViewCells({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final itemWidth = constraints.maxWidth / 7;
      final AgendaController agendaController = Get.find();
      return Obx(() {
        final date = agendaController.date.value;
        final startHour = agendaController.startHour.value;
        final endHour = agendaController.endHour.value;
        final cells = getCells(date, startHour, endHour);
        return GridView.builder(
            itemCount: cells.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: itemWidth / (hourHeight / 2.0)),
            itemBuilder: (ctx, i) => Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: cells.length - i <= 7 || cells[i].end.minute != 0
                        ? BorderSide.none
                        : const BorderSide(width: 1.0, color: Colors.black),
                    right: (i + 1) % 7 == 0
                        ? BorderSide.none
                        : const BorderSide(width: 1.0, color: Colors.black),
                  )),
                  child: CellItem(cell: cells[i]),
                ));
      });
    });
  }
}
