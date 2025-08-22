import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/notes/models/note_model.dart';

class NotesController extends GetxController {
  // --- Değişkenler ---
  var notes = <NoteModel>[].obs;

  final box = GetStorage();
  String activeUser =
      ''; // Hangi kullanıcının notlarını yöneteceğimizi bilmek için.
  int _nextId = 0; // Yeni notlar için ID sayacı.

  @override
  void onInit() {
    super.onInit();
    // onInit artık boş. Veri yükleme, login sonrası AuthController tarafından tetiklenecek.
    print("NotesController oluşturuldu, kullanıcı girişi bekleniyor.");
  }

  /// AuthController tarafından çağrılan, kullanıcıya özel notları yükleyen ana metot.
  void loadUserSpecificData(String username) {
    activeUser = username;
    print("NotesController: '$activeUser' için notlar yükleniyor...");

    // Önceki kullanıcıdan kalabilecek notları temizle
    notes.clear();

    // Kullanıcıya özel notları yükle
    List? savedNotes = box.read<List>('${activeUser}_notes');
    if (savedNotes != null) {
      notes.value = savedNotes
          .map(
            (noteJson) => NoteModel.fromJson(noteJson as Map<String, dynamic>),
          )
          .toList();
      // En büyük ID'yi bul ve bir sonraki ID'yi ayarla (en güvenli yöntem)
      _nextId = notes.isNotEmpty
          ? notes.map((n) => n.id).reduce((a, b) => a > b ? a : b) + 1
          : 0;
    } else {
      _nextId = 0; // Eğer kullanıcı için hiç kayıtlı not yoksa ID'yi sıfırla.
    }

    print(
      "'$activeUser' için not yükleme tamamlandı. Not sayısı: ${notes.length}",
    );
  }

  // --- KAYDETME METODU (Artık kullanıcıya özel) ---
  void saveNotes() {
    if (activeUser.isEmpty) return; // Kullanıcı yoksa kaydetme
    box.write(
      '${activeUser}_notes',
      notes.map((note) => note.toJson()).toList(),
    );
  }

  // --- VERİ DEĞİŞTİRME METOTLARI (Artık hepsi saveNotes() çağırıyor) ---

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
      final homeController = Get.find<HomeController>();
      final NoteModel noteToPin = notes.firstWhere((note) => note.id == noteId);
      homeController.pinNewNote(noteToPin.content);

      Get.snackbar(
        "Başarılı",
        "Not ana sayfaya sabitlendi!",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Hata",
        "Not sabitlenirken bir sorun oluştu.",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("pinNote hatası: $e");
    }
  }

  void clearUserData() {
    notes.clear();
    activeUser = '';
    _nextId = 0;
  }
}
