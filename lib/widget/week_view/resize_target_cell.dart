import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/model/cell.dart';
import 'package:get/get.dart';

import '../../model/event_resize.dart';

class ResizeTargetCell extends StatelessWidget {
  const ResizeTargetCell({super.key, required this.cell});
  final Cell cell;
  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    return DragTarget<EventResize>(
        onWillAccept: (data) {
          if (data == null) {
            return false;
          }
          if (data.type == ResizeType.start) {
            agendaController.updateResizeStart(data.event, cell.end);
          }
          if (data.type == ResizeType.end) {
            agendaController.updateResizeEnd(data.event, cell.start);
          }
          return true;
        },
        builder: (ctx, candidateData, rejectedData) => Container());
  }
}

// class DragTargetCell extends StatelessWidget {
//   const DragTargetCell({super.key, required this.cell});
//   final Cell cell;

//   @override
//   Widget build(BuildContext context) {
//     final AgendaController agendaController = Get.find();
//     return DragTarget<EventDrag>(
//       onWillAccept: (data) {
//         agendaController.updateEvent(data!.event, cell.start);
//         return true;
//       },
//       builder: (context, candidateData, rejectedData) => Container(),
//     );
//   }
// }