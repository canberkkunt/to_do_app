import 'package:get/get.dart';
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
    Get.offAllNamed(AppRoutes.home, arguments: name.trim());
    updateGreeting();
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
}
