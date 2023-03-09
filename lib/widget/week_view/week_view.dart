import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/controller/layout_controller.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:flutter_calendar/widget/week_view/all_day_events.dart';
import 'package:flutter_calendar/widget/week_view/week_view_events.dart';
import 'package:get/get.dart';
import '../../util/date_util.dart';
import 'week_day_header.dart';
import 'week_view_cells.dart';
import 'week_view_header.dart';
import 'week_view_side_bar.dart';

class WeekView extends StatelessWidget {
  const WeekView({super.key, this.startHour = 0, this.endHour = 24});
  final int startHour;
  final int endHour;
  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    final LayoutController layoutController = Get.find();
    layoutController.startHour.value = startHour;
    layoutController.endHour.value = endHour;
    layoutController.dayHeigth.value = (endHour - startHour) * hourHeight;
    return SingleChildScrollView(child: LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return Column(
          children: [
            const WeekViewHeader(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: width * 19 / 20,
                  height: hourHeight,
                  child: Obx(() {
                    final days = getDays(agendaController.date.value);
                    return Row(
                      children: List.generate(days.length,
                          (i) => Expanded(child: WeekDayHeader(day: days[i])),
                          growable: false),
                    );
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  final date = agendaController.date.value;
                  final allDayEvents = agendaController
                      .getEventsByWeek(date)
                      .where((e) => e.allDay)
                      .toList();
                  return SizedBox(
                      width: width * 19 / 20,
                      height: allDayEvents.length * (hourHeight / 2.0),
                      child: AllDayEvents(
                        events: allDayEvents,
                      ));
                }),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: width * 1 / 20, child: const WeekViewSideBar()),
                SizedBox(
                  width: width * 19 / 20,
                  child: Stack(children: const [
                    WeekViewCells(),
                    WeekViewEvents(),
                  ]),
                ),
              ],
            ),
          ],
        );
      },
    ));
  }
}
