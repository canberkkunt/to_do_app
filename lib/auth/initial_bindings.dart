import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:to_do_app/auth/auth_controller.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/notes/notes_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(NotesController(), permanent: true);
  }
}
