import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/auth/auth_controller.dart';
import 'package:to_do_app/pages/calendar/calendar_page.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/home/widget/task_list_widget.dart';
import 'package:to_do_app/pages/notes/notes_page.dart';
import 'package:to_do_app/pages/settings/settings_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO APP', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        actions: [
          IconButton(
            onPressed: () {
              final AuthController authController = Get.find<AuthController>();
              authController.logOut();
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade900,

      // DÜZELTME 1: Body artık seçili indekse göre dinamik olarak değişiyor.
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            TaskListWidget(),
            CalendarPage(),
            NotesPage(),
            SettingsPage(),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _newTaskWindow(context, controller);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // İkon 0
              IconButton(
                onPressed: () => controller.changeIndex(0),
                icon: const Icon(Icons.home),
                color: controller.selectedIndex.value == 0
                    ? Colors.blue
                    : Colors.grey,
              ),
              // İkon 1
              IconButton(
                onPressed: () => controller.changeIndex(1),
                icon: const Icon(Icons.calendar_month),
                color: controller.selectedIndex.value == 1
                    ? Colors.blue
                    : Colors.grey,
              ),
              const SizedBox(width: 40.0), // Buton için boşluk
              // İkon 2 (DÜZELTME 2: İndeksler düzeltildi)
              IconButton(
                onPressed: () => controller.changeIndex(2),
                icon: const Icon(Icons.note_alt_outlined),
                color: controller.selectedIndex.value == 2
                    ? Colors.blue
                    : Colors.grey,
              ),
              // İkon 3
              IconButton(
                onPressed: () => controller.changeIndex(3),
                icon: const Icon(Icons.settings),
                color: controller.selectedIndex.value == 3
                    ? Colors.blue
                    : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _newTaskWindow(BuildContext context, HomeController controller) {
    final TextEditingController textEditingController = TextEditingController();
    return Get.dialog(
      AlertDialog(
        title: Text('Görevi Gir!'),
        content: TextField(
          controller: textEditingController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Görevinizi Buraya Giriniz...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              String taskTitle = textEditingController.text;
              controller.addTask(taskTitle);
              Get.back();
            },
            child: Text('Ekle'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
