import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:to_do_app/pages/calendar/calendar_page.dart';
import 'package:to_do_app/pages/home/home_bindings.dart';
import 'package:to_do_app/pages/home/home_page.dart';
import 'package:to_do_app/pages/login/login_bindings.dart';
import 'package:to_do_app/pages/login/login_page.dart';
import 'package:to_do_app/pages/notes/notes_binding.dart';
import 'package:to_do_app/pages/notes/notes_page.dart';
import 'package:to_do_app/pages/settings/settings_page.dart';

abstract class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String settings = '/settings';
  static const String calendar = '/calendar';
  static const String notes = '/notes';

  static final pages = <GetPage>[
    GetPage(name: '/home', page: () => HomePage(), binding: HomeBindings()),
    GetPage(name: '/login', page: () => LoginPage(), binding: LoginBindings()),
    GetPage(name: '/settings', page: () => SettingsPage()),
    GetPage(name: '/calendar', page: () => CalendarPage()),
    GetPage(name: '/notes', page: () => NotesPage(), binding: NotesBinding()),
  ];
}
