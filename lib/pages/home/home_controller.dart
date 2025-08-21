import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:to_do_app/pages/home/model/task_model.dart';

class HomeController extends GetxController {
  var userName = 'Misafir'.obs;
  var tasks = <TaskModel>[].obs;
  int _nextId = 0;
  var selectedIndex = 0.obs;
  var pinnedNotes = <String>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadData();
    print('Görevleri geliyor...');
    print('Argümanlar ${Get.arguments}');

    if (Get.arguments != null && Get.arguments is String) {
      userName.value = Get.arguments;
      print("Başarılı: userName değişkenine '${Get.arguments}' atandı.");
    } else {
      print(
        "Uyarı: Geçerli bir argüman gelmedi. userName varsayılan değerde ('${userName.value}') kalacak.",
      );
    }
    print("---------------------------------");
  }

  void addTask(String title) {
    if (title.trim().isEmpty) {
      Get.snackbar('Hata', 'Görev boş bırakılmaz');
      return;
    }
    final newTask = TaskModel(id: _nextId, title: title.trim());
    tasks.add(newTask);
    _nextId++;
    saveTasks();
  }

  void toggleTaskStatus(int id) {
    try {
      final task = tasks.firstWhere((task) => task.id == id);
      task.isDone = !task.isDone;
      tasks.refresh();
      saveTasks();
    } catch (e) {
      print('Hata: ID\'si $id olan görev bulunamadı.');
    }
  }

  void removeTask(int id) {
    tasks.removeWhere((task) => task.id == id);
    Get.snackbar('Başarılı', 'Görev başarıyla silindi');
    saveTasks();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void pinNewNote(String noteContent) {
    if (!pinnedNotes.contains(noteContent)) {
      pinnedNotes.add(noteContent);
      savePinnedNotes();
    } else {
      Get.snackbar('HATA', 'Aynı notu sabitleyemezsiniz');
    }
  }

  void unPinNote(String noteContent) {
    pinnedNotes.remove(noteContent);
    Get.snackbar('Başarılı', 'Sabitlenme kaldırıldı');
    savePinnedNotes();
  }

  void saveTasks() {
    box.write('tasks', tasks.map((task) => task.toJson()).toList());
    print('Görevler Storageye kaydetti');
  }

  void savePinnedNotes() {
    box.write('pinned_notes', pinnedNotes.toList());
    print('Sabitlenmiş Notlar kaydedildi');
  }

  void loadData() {
    List? savedTasks = box.read<List>('tasks');
    if (savedTasks != null) {
      tasks.value = savedTasks
          .map((taskJson) => TaskModel.fromJson(taskJson))
          .toList();
      _nextId = tasks.length;
    }
    List? savedPinnedNotes = box.read<List>('pinned_notes');
    if (savedPinnedNotes != null) {
      pinnedNotes.value = List<String>.from(savedPinnedNotes);
    }
    print("Veriler GetStorage'dan yüklendi.");
  }
}
