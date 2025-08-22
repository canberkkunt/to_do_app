import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/pages/home/model/task_model.dart';

class HomeController extends GetxController {
  // --- Değişkenler ---
  // Artık bu controller'da 'userName' tutmuyoruz. Bu bilgi AuthController'da.
  var tasks = <TaskModel>[].obs;
  var pinnedNotes = <String>[].obs;
  var selectedIndex = 0.obs;

  final box = GetStorage();
  String activeUser =
      ''; // Hangi kullanıcının verilerini yöneteceğimizi bilmek için.
  int _nextId = 0; // Yeni görevler için ID sayacı.

  @override
  void onInit() {
    super.onInit();
    // onInit artık boş. Veri yükleme, login sonrası AuthController tarafından tetiklenecek.
    print("HomeController oluşturuldu, kullanıcı girişi bekleniyor.");
  }

  /// AuthController tarafından çağrılan, kullanıcıya özel verileri yükleyen ana metot.
  void loadUserSpecificData(String username) {
    activeUser = username;
    print("HomeController: '$activeUser' için veriler yükleniyor...");

    // Önceki kullanıcıdan kalabilecek verileri temizle
    tasks.clear();
    pinnedNotes.clear();

    // Kullanıcıya özel görevleri yükle
    List? savedTasks = box.read<List>('${activeUser}_tasks');
    if (savedTasks != null) {
      tasks.value = savedTasks
          .map(
            (taskJson) => TaskModel.fromJson(taskJson as Map<String, dynamic>),
          )
          .toList();
      // En büyük ID'yi bul ve bir sonraki ID'yi ayarla (en güvenli yöntem)
      _nextId = tasks.isNotEmpty
          ? tasks.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1
          : 0;
    } else {
      _nextId = 0; // Eğer kullanıcı için hiç kayıtlı görev yoksa ID'yi sıfırla.
    }

    // Kullanıcıya özel sabitlenmiş notları yükle
    List? savedPinnedNotes = box.read<List>('${activeUser}_pinned_notes');
    if (savedPinnedNotes != null) {
      pinnedNotes.value = List<String>.from(savedPinnedNotes);
    }

    print(
      "'$activeUser' için yükleme tamamlandı. Görev sayısı: ${tasks.length}, Not sayısı: ${pinnedNotes.length}",
    );
  }

  // --- KAYDETME METOTLARI (Artık kullanıcıya özel ve doğru) ---
  void saveTasks() {
    if (activeUser.isEmpty)
      return; // Kullanıcı yoksa kaydetme (güvenlik önlemi)
    box.write(
      '${activeUser}_tasks',
      tasks.map((task) => task.toJson()).toList(),
    );
  }

  void savePinnedNotes() {
    if (activeUser.isEmpty) return;
    box.write('${activeUser}_pinned_notes', pinnedNotes.toList());
  }

  // --- VERİ DEĞİŞTİRME METOTLARI (Bunlarda değişiklik yok, hepsi doğru çalışıyor) ---

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

  void pinNewNote(String noteContent) {
    if (!pinnedNotes.contains(noteContent)) {
      pinnedNotes.add(noteContent);
      savePinnedNotes();
    } else {
      Get.snackbar('HATA', 'Aynı notu sabitleyemezsiniz');
    }
  }

  void unpinNote(String noteContent) {
    pinnedNotes.remove(noteContent);
    Get.snackbar('Başarılı', 'Sabitlenme kaldırıldı');
    savePinnedNotes();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void clearUserData() {
    tasks.clear();
    pinnedNotes.clear();
    activeUser = '';
    _nextId = 0;
  }
}
