import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/model/cell.dart';
import 'package:get/get.dart';

import '../../model/event_drag.dart';

class DragTargetCell extends StatelessWidget {
  const DragTargetCell({super.key, required this.cell});
  final Cell cell;

  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    return DragTarget<EventDrag>(
      onWillAccept: (data) {
        if (data == null) {
          return false;
        }
        agendaController.updateDrag(data.event, cell.start);
        return true;
      },
      builder: (ctx, candidateData, rejectedData) => Container(),
    );
  }
}