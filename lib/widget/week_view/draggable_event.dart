import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/model/event_drag.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:get/get.dart';

import '../../model/event.dart';

class DraggableEvent extends StatelessWidget {
  const DraggableEvent({super.key, required this.event, required this.width});
  final Event event;
  final double width;
  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    final duration = event.end.difference(event.start);
    final heigth = hourHeight * (duration.inMinutes / 60.0);
    final shouldCrop = heigth > 32.0;
    return Column(
      children: [
        if (shouldCrop) const SizedBox(height: 8.0),
        SizedBox(
          height: shouldCrop ? heigth - 16.0 : heigth,
          child: Draggable<EventDrag>(
            onDragStarted: () => agendaController.dragging.value = true,
            onDragEnd: (_) => agendaController.dragging.value = false,
            onDragCompleted: () => agendaController.dragging.value = false,
            onDraggableCanceled: (v, o) =>
                agendaController.dragging.value = false,
            maxSimultaneousDrags: 1,
            data: EventDrag(event),
            feedback: Container(),
            child: Container(
              width: width,
              color: shouldCrop ? event.color : null,
              decoration: shouldCrop
                  ? null
                  : BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0)),
                      color: event.color,
                    ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  event.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        if (shouldCrop) const SizedBox(height: 8.0),
      ],
    );
  }
}
