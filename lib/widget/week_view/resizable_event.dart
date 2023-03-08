import 'package:flutter/material.dart';
import 'package:flutter_calendar/model/event_resize.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:get/get.dart';

import '../../controller/agenda_controller.dart';
import '../../model/event.dart';

class ResizableEvent extends StatelessWidget {
  const ResizableEvent({super.key, required this.event, required this.width});
  final Event event;
  final double width;
  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    final duration = event.end.difference(event.start);
    final heigth = cellHeight * (duration.inMinutes / 60.0);
    return SizedBox(
      height: heigth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Draggable<EventResize>(
            onDragStarted: () => agendaController.dragging.value = true,
            onDragEnd: (_) => agendaController.dragging.value = false,
            onDragCompleted: () => agendaController.dragging.value = false,
            maxSimultaneousDrags: 1,
            data: EventResize(event, ResizeType.start),
            feedback: Container(),
            child: Container(
              width: width,
              height: heigth > 32.0 ? 8.0 : 0.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0)),
                color: event.color,
              ),
            ),
          ),
          Draggable<EventResize>(
            onDragStarted: () => agendaController.dragging.value = true,
            onDragEnd: (_) => agendaController.dragging.value = false,
            onDragCompleted: () => agendaController.dragging.value = false,
            maxSimultaneousDrags: 1,
            data: EventResize(event, ResizeType.end),
            feedback: Container(),
            child: Container(
              width: width,
              height: heigth > 32.0 ? 8.0 : 0.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0)),
                color: event.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
