import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.grey, endIndent: 24, indent: 24),

            // --- 2. BÖLÜM: GÖREVLER ---
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                "Görevlerin",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
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
                  return ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (value) {
                        controller.toggleTaskStatus(task.id);
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
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
              child: Text(
                "Sabitlenmiş Notlar",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ),
            Obx(
              () => controller.pinnedNotes.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24.0,
                      ),
                      child: Center(
                        child: Text(
                          'Henüz sabitlenmiş bir not yok.',
                          style: TextStyle(color: Colors.white54),
                        ),
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
                                  controller.unPinNote(noteContent);
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
