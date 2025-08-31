import 'package:get/get.dart';
import 'package:to_do_app/pages/pomodoro/pomodoro_controller.dart';

class PomodoroBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PomodoroController>(() => PomodoroController());
  }
}
