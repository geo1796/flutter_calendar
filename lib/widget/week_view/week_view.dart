import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:flutter_calendar/util/layout_util.dart';
import 'package:flutter_calendar/widget/week_view/week_view_events.dart';
import 'package:get/get.dart';
import '../../util/date_util.dart';
import 'week_day_header.dart';
import 'week_view_cells.dart';
import 'week_view_header.dart';
import 'week_view_side_bar.dart';

class WeekView extends StatelessWidget {
  const WeekView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final AgendaController agendaController = Get.find();
    return SingleChildScrollView(
      child: Column(
        children: [
          WeekViewHeader(),
          Row(
            children: [
              SizedBox(
                width: mediaQuery.size.width * 1 / 20,
                height: cellHeight,
              ),
              SizedBox(
                width: mediaQuery.size.width * 19 / 20,
                height: cellHeight,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: mediaQuery.size.width * 1 / 20,
                  child: const WeekViewSideBar()),
              SizedBox(
                width: mediaQuery.size.width * 19 / 20,
                child: Stack(children: [
                  Obx(() {
                    return WeekViewCells(date: agendaController.date.value);
                  }),
                  const WeekViewEvents(),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
