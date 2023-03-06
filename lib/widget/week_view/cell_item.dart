import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/model/cell.dart';
import 'package:flutter_calendar/model/event.dart';
import 'package:get/get.dart';

class CellItem extends StatelessWidget {
  const CellItem({super.key, required this.cell});
  final Cell cell;
  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    return DragTarget<Event>(
      onWillAccept: (data) {
        agendaController.updateEvent(data!, cell.start);
        return true;
      },
      // onAccept: (data) {
      //   final duration = data.end.difference(data.start);
      //   data.start = cell.start;
      //   data.end = data.start.add(duration);
      //   agendaController.updateEvent(data);
      // },
      builder: (context, candidateData, rejectedData) => Container(),
    );
  }
}
