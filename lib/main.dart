import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/auth/initial_bindings.dart';
import 'package:to_do_app/routes/app_routes.dart';
import 'package:to_do_app/theme/app_themes.dart';
import 'package:to_do_app/translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      locale: Locale('tr', 'TR'),
      fallbackLocale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      initialBinding: InitialBindings(),
      getPages: AppRoutes.pages,
      theme: AppThemes.darkTheme,
    );
  }
}
