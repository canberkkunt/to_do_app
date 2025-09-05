import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/auth/auth_controller.dart';
import 'package:to_do_app/theme/theme_controller.dart';

// GetWidget kullanmak, Get.find() ve Obx'i birleştirdiği için daha temiz olabilir,
// ama StatelessWidget ile de devam edebiliriz.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller'ı build metodunun başında bir kere buluyoruz.
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Ayarlar')),
      // DÜZELTME 1: Arka plan rengini artık temadan alıyoruz.
      // Buraya bir renk yazmıyoruz, Scaffold temanın scaffoldBackgroundColor'ını
      // otomatik olarak kullanacaktır.

      // DÜZELTME 4: Center yerine ListView kullanarak
      // hem içeriğin üstten başlamasını hem de taşma durumunda
      // kaydırılabilir olmasını sağlıyoruz.
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Tema Seçimi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // DÜZELTME 3: ListTile'ları Obx ile sarmalıyoruz ki
          // 'trailing' ikonu (tik) anında güncellensin.
          Obx(
            () => Column(
              children: [
                // Açık Tema
                ListTile(
                  title: const Text('Açık Tema'),
                  leading: const Icon(Icons.wb_sunny_outlined),
                  onTap: () => themeController.changeTheme('light'),
                  // Koşullu 'trailing' ikonu
                  trailing: themeController.currentTheme == 'light'
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),

                // Karanlık Tema
                ListTile(
                  title: const Text('Karanlık Tema'),
                  leading: const Icon(Icons.nightlight_round_outlined),
                  onTap: () => themeController.changeTheme('dark'),
                  trailing: themeController.currentTheme == 'dark'
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),

                // Gece Mavisi Tema
                ListTile(
                  title: const Text('Gece Mavisi'),
                  leading: const Icon(Icons.palette_outlined),
                  onTap: () => themeController.changeTheme('blue'),
                  trailing: themeController.currentTheme == 'blue'
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
                ListTile(
                  title: const Text('Sepya'),
                  leading: const Icon(Icons.book_outlined),
                  onTap: () => themeController.changeTheme('sepia'),
                  trailing: themeController.currentTheme == 'sepia'
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
                ListTile(
                  title: const Text('Neon'),
                  leading: const Icon(Icons.flash_on_outlined),
                  onTap: () => themeController.changeTheme('neon'),
                  trailing: themeController.currentTheme == 'neon'
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    final AuthController authController =
                        Get.find<AuthController>();
                    authController.logOut();
                  },
                  child: Text('Çıkış Yap'),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Dil Seçimi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text('Türkçe'),
                  leading: Icon(Icons.flag),
                  onTap: () => themeController.changeLanguage('tr_TR'),
                  trailing: themeController.currentLanguage == 'tr_TR'
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
                ListTile(
                  title: Text('English'),
                  leading: Icon(Icons.flag_circle_outlined),
                  onTap: () => themeController.changeLanguage('en_US'),
                  trailing: themeController.currentLanguage == 'en_US'
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
