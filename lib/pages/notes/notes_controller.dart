import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/notes/models/note_model.dart';

class NotesController extends GetxController {
  var notes = <NoteModel>[].obs;
  int _nextId = 0;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  void addNote(String content) {
    if (content.trim().isEmpty) {
      Get.snackbar(
        'Hata',
        'Not içeriği boş olamaz',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final newNote = NoteModel(id: _nextId, content: content.trim());
    notes.insert(0, newNote);
    _nextId++;
    saveNotes();
  }

  void removeNote(int id) {
    notes.removeWhere((note) => note.id == id);
    saveNotes();
  }

  void pinNote(int noteId) {
    try {
      // 1. ADIM: "Alıcı"yı bul.
      // GetX'in hafızasından HomeController'ın o anki çalışan örneğini buluyoruz.
      final homeController = Get.find<HomeController>();

      // 2. ADIM: Gönderilecek "Paket"i hazırla.
      // Kendi 'notes' listemizden, verilen ID'ye sahip notu buluyoruz.
      final NoteModel noteToPin = notes.firstWhere((note) => note.id == noteId);

      // 3. ADIM: "Paket"i gönder.
      // homeController'daki 'pinNewNote' fonksiyonunu,
      // bulduğumuz notun içeriğiyle (.content) çağırıyoruz.
      homeController.pinNewNote(noteToPin.content);

      // 4. ADIM: Kullanıcıya geri bildirim ver.
      Get.snackbar(
        "Başarılı",
        "Not ana sayfaya sabitlendi!",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      // Eğer bir hata olursa (örn: not bulunamazsa), kullanıcıya bilgi ver.
      Get.snackbar(
        "Hata",
        "Not sabitlenirken bir sorun oluştu.",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("pinNote hatası: $e");
    }
  }

  void loadNotes() {
    List? savedNotes = box.read<List>('notes');
    if (savedNotes != null) {
      notes.value = savedNotes
          .map((noteJson) => NoteModel.fromJson(noteJson))
          .toList();
      _nextId = notes.length;
    }
    print('Notlar Başarıyla yüklendi.');
  }

  void saveNotes() {
    box.write('notes', notes.map((note) => note.toJson()).toList());
  }
}
