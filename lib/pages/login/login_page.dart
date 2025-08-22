import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:to_do_app/auth/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              controller: nameController,
              decoration: InputDecoration(
                label: Text(
                  'İsminizi Girin',
                  style: TextStyle(color: Colors.white),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                controller.login(nameController.text);
              },
              child: Text('Giriş Yap', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
