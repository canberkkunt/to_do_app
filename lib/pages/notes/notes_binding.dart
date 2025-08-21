import 'package:get/get.dart';
import 'package:to_do_app/pages/notes/notes_controller.dart';

class NotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotesController());
  }
}
