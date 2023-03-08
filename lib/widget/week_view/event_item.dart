import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/model/event.dart';
import 'package:flutter_calendar/model/event_position.dart';
import 'package:flutter_calendar/widget/week_view/draggable_event.dart';
import 'package:flutter_calendar/widget/week_view/resizable_event.dart';
import 'package:get/get.dart';

class EventItem extends StatelessWidget {
  const EventItem(
      {super.key,
      required this.width,
      required this.event,
      required this.position});
  final double width;
  final Event event;
  final EventPosition position;
  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    return Obx(() => Positioned(
          width: position.width,
          top: position.top,
          bottom: position.bottom,
          left: position.left,
          child: IgnorePointer(
            ignoring: agendaController.dragging.value,
            // child: DraggableEvent(event: event, width: width),
            child: Stack(children: [
              ResizableEvent(event: event, width: width),
              DraggableEvent(event: event, width: width),
            ]),
          ),
        ));
  }
}
