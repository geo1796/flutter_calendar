import 'package:flutter/material.dart';
import 'package:flutter_calendar/util/layout_util.dart';

class WeekViewSideBar extends StatelessWidget {
  const WeekViewSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
          24,
          (i) => SizedBox(
                height: cellHeight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('${i}h'),
                ),
              )),
    );
  }
}
