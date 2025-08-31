import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/auth/auth_controller.dart';
import 'package:to_do_app/pages/home/home_controller.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller'ları buluyoruz.
    final HomeController controller = Get.find<HomeController>();
    final AuthController authController = Get.find<AuthController>();

    // SingleChildScrollView, tüm içeriği tek bir kaydırılabilir alan haline getirir.
    // Bu, "unbounded height" hatası olmadan Column içinde ListView kullanmanın
    // en yaygın yollarından biridir.
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
        ), // En altta genel bir boşluk bırakmak için
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. BÖLÜM: HOŞGELDİN MESAJI ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => Text(
                  '${authController.greeting.value}, ${authController.userName.value}',
                  style: GoogleFonts.montserrat(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.grey, endIndent: 24, indent: 24),

            // --- 2. BÖLÜM: GÖREVLER ---
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text("Görevlerin", style: TextStyle(fontSize: 18)),
            ),
            Obx(
              () => ListView.builder(
                // shrinkWrap: true -> ListView'e "içeriğin kadar büyü, fazlası değil" der.
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics() -> Bu ListView'in kendi kaydırmasını engeller
                // ve kontrolü dıştaki SingleChildScrollView'a bırakır.
                // Bu, iç içe kaydırma hatalarını önler.
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final taskDate = DateTime(
                    task.date.year,
                    task.date.month,
                    task.date.day,
                  );
                  final bool isFutureTask = taskDate.isAfter(today);
                  return ListTile(
                    tileColor: task.isDone ? Colors.grey.shade800 : null,
                    subtitle: isFutureTask
                        ? Text(
                            'Tarih: ${task.date.day}/${task.date.month}/${task.date.year}',
                            style: TextStyle(fontSize: 12),
                          )
                        : null,

                    leading: Checkbox(
                      activeColor: Colors.redAccent,
                      value: task.isDone,
                      onChanged: (value) {
                        controller.toggleTaskStatus(task.id);
                      },
                    ),
                    title: Text(task.title),
                    trailing: IconButton(
                      onPressed: () {
                        controller.removeTask(task.id);
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  );
                },
              ),
            ),

            const Divider(color: Colors.grey, endIndent: 24, indent: 24),

            // --- 3. BÖLÜM: SABİTLENMİŞ NOTLAR ---
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text("Sabitlenmiş Notlar", style: TextStyle(fontSize: 18)),
            ),
            Obx(
              () => controller.pinnedNotes.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24.0,
                      ),
                      child: Center(
                        child: Text('Henüz sabitlenmiş bir not yok.'),
                      ),
                    )
                  : Column(
                      children: [
                        ...controller.pinnedNotes.map((noteContent) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 4.0,
                            ),
                            color: Colors.grey.shade800,
                            child: ListTile(
                              leading: const Icon(
                                Icons.push_pin,
                                color: Colors.amber,
                              ),
                              title: Text(
                                noteContent,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  controller.unpinNote(noteContent);
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
