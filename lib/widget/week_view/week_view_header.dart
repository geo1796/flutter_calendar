import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:get/get.dart';

import '../../util/date_util.dart';

class WeekViewHeader extends StatelessWidget {
  const WeekViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                color: theme.primaryColor),
            width: width * 19 / 20,
            child: Obx(() {
              final date = agendaController.date.value;
              final startOfWeek = getStartOfWeek(date);
              final endOfWeek = getEndOfWeek(date);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      color: theme.secondaryHeaderColor,
                      onPressed: () =>
                          agendaController.date.value = getLastWeek(date),
                      icon: const Icon(Icons.arrow_back)),
                  Text(
                    '${formatFR(startOfWeek)} - ${formatFR(endOfWeek)}',
                    style: TextStyle(color: theme.secondaryHeaderColor),
                  ),
                  IconButton(
                      color: theme.secondaryHeaderColor,
                      onPressed: () =>
                          agendaController.date.value = getNextWeek(date),
                      icon: const Icon(Icons.arrow_forward)),
                ],
              );
            }),
          ),
        ],
      );
    });
  }
}
