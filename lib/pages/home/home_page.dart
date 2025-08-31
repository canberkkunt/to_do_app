import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/auth/auth_controller.dart';
import 'package:to_do_app/pages/calendar/calendar_page.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/home/widget/task_list_widget.dart';
import 'package:to_do_app/pages/notes/notes_page.dart';
import 'package:to_do_app/pages/pomodoro/pomodoro_page.dart';
import 'package:to_do_app/pages/settings/settings_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarTextStyle = Theme.of(context).appBarTheme.titleTextStyle;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Make Your Dream',
          style: GoogleFonts.italiana(
            textStyle: appBarTextStyle,
            fontSize: 28.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),

      // DÜZELTME 1: Body artık seçili indekse göre dinamik olarak değişiyor.
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            TaskListWidget(),
            CalendarPage(),
            NotesPage(),
            PomodoroPage(),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _newTaskWindow(context, controller);
        },
        child: const Icon(Icons.add, color: Colors.black),
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
                    ? Colors.redAccent
                    : Colors.grey,
              ),
              // İkon 1
              IconButton(
                onPressed: () => controller.changeIndex(1),
                icon: const Icon(Icons.calendar_month),
                color: controller.selectedIndex.value == 1
                    ? Colors.redAccent
                    : Colors.grey,
              ),
              const SizedBox(width: 40.0), // Buton için boşluk
              // İkon 2 (DÜZELTME 2: İndeksler düzeltildi)
              IconButton(
                onPressed: () => controller.changeIndex(2),
                icon: const Icon(Icons.note_alt_outlined),
                color: controller.selectedIndex.value == 2
                    ? Colors.redAccent
                    : Colors.grey,
              ),
              // İkon 3
              IconButton(
                onPressed: () => controller.changeIndex(3),
                icon: const Icon(Icons.add_alarm),
                color: controller.selectedIndex.value == 3
                    ? Colors.redAccent
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
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          child: TextField(
            maxLines: 5,
            controller: textEditingController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Görevinizi Buraya Giriniz...',
              border: OutlineInputBorder(),
            ),
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
              final bool isSuccess = controller.addTask(taskTitle);
              Get.back();
              if (!isSuccess) {
                // Eğer işlem başarısız olduysa (addTask 'false' döndürdüyse),
                // kullanıcıya nedenini söyleyen bir uyarı göster.
                Get.snackbar(
                  'Başarısız',
                  'Görev eklenemedi. Başlık boş veya bu görev zaten mevcut.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                );
              }
            },
            child: Text('Ekle'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
