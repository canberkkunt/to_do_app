import 'package:get/get.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/notes/notes_controller.dart';
import 'package:to_do_app/routes/app_routes.dart';

class AuthController extends GetxController {
  var userName = ''.obs;
  var greeting = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateGreeting();
  }

  void login(String name) {
    if (name.trim().isEmpty) {
      Get.snackbar('HATA', 'İsim boş bırakalamaz!');
      return;
    }

    userName.value = name.trim();
    print("HomePage'e gönderilen isim: '${name.trim()}'");

    updateGreeting();

    final HomeController homeController = Get.find<HomeController>();
    final NotesController notesController = Get.find<NotesController>();

    homeController.loadUserSpecificData(userName.value);
    notesController.loadUserSpecificData(userName.value);
    Get.offAllNamed(AppRoutes.home);
  }

  void updateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;
    if (hour < 12) {
      greeting.value = 'Günaydın';
    } else if (hour < 18) {
      greeting.value = 'Tünaydın';
    } else if (hour < 22) {
      greeting.value = 'İyi Akşamlar';
    } else {
      greeting.value = 'İyi Geceler';
    }
  }

  void logOut() {
    userName.value = '';
    greeting.value = '';

    print("Kullanıcı çıkış yaptı. Veriler sıfırlanıyor...");

    final HomeController homeController = Get.find<HomeController>();
    final NotesController notesController = Get.find<NotesController>();

    homeController.clearUserData();
    notesController.clearUserData();
    Get.offAllNamed(AppRoutes.login);
  }
}
