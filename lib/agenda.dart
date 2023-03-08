import 'package:flutter/material.dart';

import 'widget/week_view/week_view.dart';

class Agenda extends StatelessWidget {
  const Agenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 2 / 3,
          child: const WeekView()),
    );
  }
}
