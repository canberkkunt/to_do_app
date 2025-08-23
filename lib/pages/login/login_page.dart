import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Tam Get import'u daha iyi
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/auth/auth_controller.dart';

// DÜZELTME 1: GetView yerine normal StatelessWidget kullanıyoruz.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller'ı build metodunun başında manuel olarak buluyoruz.
    // Bu, "controller not found" hatasını önler.
    final AuthController authController = Get.find<AuthController>();
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              totalRepeatCount: 1, // Bu, repeatForever: false'dan daha nettir.
              animatedTexts: [
                TyperAnimatedText(
                  'Make Your Dream',
                  speed: const Duration(milliseconds: 150),
                  textStyle: GoogleFonts.italiana(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // İYİLEŞTİRME: Animasyon ile TextField arasına boşluk ekleyelim.
            const SizedBox(height: 50.0),

            TextField(
              style: const TextStyle(color: Colors.white),
              controller: nameController,
              decoration: InputDecoration(
                // İYİLEŞTİRME: 'label' yerine 'labelText' daha iyi bir UX sunar.
                labelText: 'İsminizi Girin',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onSubmitted: (value) {
                // Klavyeden "enter"a basınca da giriş yapsın.
                authController.login(value);
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Butonun arka plan rengi
                foregroundColor: Colors.black, // Üzerindeki yazının rengi
              ),
              onPressed: () {
                // DÜZELTME 2: 'controller.login' yerine 'authController.login'
                authController.login(nameController.text);
              },
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
