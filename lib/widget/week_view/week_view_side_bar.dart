import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/controller/layout_controller.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:get/get.dart';

class WeekViewSideBar extends StatelessWidget {
  const WeekViewSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();
    return Obx(() {
      final startHour = layoutController.startHour.value;
      final endHour = layoutController.endHour.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
            endHour - startHour,
            (i) => SizedBox(
                  height: hourHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('${i + startHour}h'),
                  ),
                )),
      );
    });
  }
}
