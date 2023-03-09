import 'package:flutter_calendar/util/layout_util.dart';
import 'package:get/get.dart';

class LayoutController extends RxController {
  var dayHeigth = (hourHeight * 24.0).obs;
  var startHour = 0.obs;
  var endHour = 24.obs;
}
