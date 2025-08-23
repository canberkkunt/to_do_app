// lib/pages/calendar/calendar_controller.dart

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/home/model/task_model.dart';

class CalendarController extends GetxController {
  // --- HAFIZA DEĞİŞKENLERİ ---

  // Takvimin o an hangi ayı gösterdiğini (odaklandığını) tutar.
  var focusedDay = DateTime.now().obs;

  // Kullanıcının en son tıkladığı günü tutar.
  var selectedDay = DateTime.now().obs;

  // Seçilen güne ait görevleri (etkinlikleri) tutacak reaktif liste.
  // Arayüz bu listeyi dinleyecek.
  var selectedEvents = <TaskModel>[].obs;
  var calendarVersion = 0.obs;

  // --- CONTROLLER İLK OLUŞTURULDUĞUNDA ---
  @override
  void onInit() {
    super.onInit();
    final homeController = Get.find<HomeController>();
    homeController.tasks.listen((_) {
      _loadEventsForDay(selectedDay.value);
      calendarVersion++;
    });
    // Controller ilk başladığında, bugünün etkinliklerini yükle.
    _loadEventsForDay(selectedDay.value);
  }

  // =======================================================================
  // ADIM 2 - 4. MADDE: FONKSİYONLAR
  // =======================================================================

  /// Takvimde bir güne tıklandığında `TableCalendar` widget'ı tarafından çağrılır.
  void onDaySelected(DateTime day, DateTime focused) {
    // Aynı güne tekrar tekrar tıklanırsa bir şey yapma.
    if (!isSameDay(selectedDay.value, day)) {
      // Seçimi ve odağı güncelle.
      selectedDay.value = day;
      focusedDay.value = focused;

      // Seçilen bu yeni gün için etkinlikleri yükle.
      _loadEventsForDay(day);
    }
  }

  /// Belirli bir güne ait tüm görevleri bulan ve `selectedEvents` listesini güncelleyen metot.
  void _loadEventsForDay(DateTime day) {
    // 1. ADIM: Tüm görevlerin olduğu ana kaynağa eriş.
    // GetX'in hafızasından HomeController'ı buluyoruz.
    final HomeController homeController = Get.find<HomeController>();

    // 2. ADIM: Filtreleme yap.
    // HomeController'daki tüm 'tasks' listesini alıp, .where() metodu ile
    // sadece tarihi 'day' ile eşleşenleri filtreliyoruz.
    final eventsForDay = homeController.tasks.where((task) {
      // Tarihleri karşılaştırırken saat, dakika gibi detayları yok saymak için
      // sadece yıl, ay ve gün değerlerinin aynı olup olmadığını kontrol ediyoruz.
      return task.date.year == day.year &&
          task.date.month == day.month &&
          task.date.day == day.day;
    }).toList(); // Filtrelenen görevleri yeni bir listeye dönüştür.

    // 3. ADIM: Arayüzün dinlediği listeyi güncelle.
    // Filtrelenmiş görev listesini, arayüzün dinlediği 'selectedEvents' listesine atıyoruz.
    selectedEvents.value = eventsForDay;
  }

  List<TaskModel> getEventsForDay(DateTime day) {
    final HomeController homeController = Get.find<HomeController>();
    final events = homeController.tasks.where((task) {
      return task.date.year == day.year &&
          task.date.month == day.month &&
          task.date.day == day.day;
    }).toList();
    return events;
  }
}
