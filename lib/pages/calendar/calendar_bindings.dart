import 'package:get/get.dart';
import 'package:to_do_app/pages/calendar/calendar_controller.dart';

class CalendarBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}
