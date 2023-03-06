import 'package:flutter/material.dart';
import 'package:flutter_calendar/controller/agenda_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../util/date_util.dart';

class WeekViewHeader extends StatelessWidget {
  WeekViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final AgendaController agendaController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(() {
        final date = agendaController.date.value;
        final startOfWeek = getStartOfWeek(date);
        final endOfWeek = getEndOfWeek(date);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () =>
                    agendaController.date.value = getLastWeek(date),
                icon: const Icon(Icons.arrow_back)),
            Text('${formatFR(startOfWeek)} - ${formatFR(endOfWeek)}'),
            IconButton(onPressed: () =>
                    agendaController.date.value = getNextWeek(date), icon: const Icon(Icons.arrow_forward)),
          ],
        );
      }),
    );
  }
}
