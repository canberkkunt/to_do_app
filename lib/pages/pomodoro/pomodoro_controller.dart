import 'dart:async';
import 'package:get/get.dart';

enum PomodoroState { working, shortBreak, longBreak, paused, stopped }

class PomodoroController extends GetxController {
  // --- Ayarlar ---
  final int workDuration = 25 * 60;
  final int shortBreakDuration = 5 * 60;
  final int longBreakDuration = 15 * 60;

  // --- Durum Değişkenleri ---
  var currentState = PomodoroState.stopped.obs;
  late RxInt remainingTime;
  var pomodoroCount = 0.obs;
  Timer? _timer;
  PomodoroState _stateBeforePause = PomodoroState.stopped;

  @override
  void onInit() {
    super.onInit();
    remainingTime = workDuration.obs;
  }

  /// "Başlat" veya "Devam Et" butonları için tek ana fonksiyon.
  /// GÖREVİ: Sadece zamanlayıcıyı (Timer) başlatmaktır.
  void startOrResumeTimer() {
    if (_timer != null && _timer!.isActive) return;

    // Eğer duraklatılmış durumdan devam ediyorsak, durumu eski haline getir.
    if (currentState.value == PomodoroState.paused) {
      currentState.value = _stateBeforePause;
    }

    // Geri kalan her şey (hangi seansın başlayacağı, sürenin ne olacağı)
    // zaten bu fonksiyondan ÖNCE ayarlanmış olmalı.

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        _moveToNextSession();
      }
    });
  }

  /// Zamanlayıcıyı duraklatır.
  void pauseTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _stateBeforePause = currentState.value;
      currentState.value = PomodoroState.paused;
    }
  }

  /// Zamanlayıcıyı ve tüm durumu tamamen sıfırlar.
  /// GÖREVİ: Her şeyi başlangıçtaki 'çalışma' durumuna hazırlamaktır.
  void resetTimer() {
    _timer?.cancel();
    currentState.value = PomodoroState.stopped;
    remainingTime.value = workDuration;
    pomodoroCount.value = 0;
  }

  /// Bir seans bittiğinde bir sonrakini hazırlar ve başlatır.
  /// GÖREVİ: Bir sonraki seansın ne olacağına karar vermek ve durumu güncellemektir.
  void _moveToNextSession() {
    // TODO: Bir ses çal veya bildirim gönder.

    // Biten seans bir çalışma seansı mıydı?
    if (currentState.value == PomodoroState.working) {
      pomodoroCount.value++;
      // Uzun mola zamanı mı?
      if (pomodoroCount.value > 0 && pomodoroCount.value % 4 == 0) {
        currentState.value = PomodoroState.longBreak;
        remainingTime.value = longBreakDuration;
      } else {
        currentState.value = PomodoroState.shortBreak;
        remainingTime.value = shortBreakDuration;
      }
    }
    // Biten seans bir mola seansı mıydı?
    else {
      // DÜZELTME: Mola bittiğinde, yeni 'çalışma' seansını burada hazırlıyoruz.
      currentState.value = PomodoroState.working;
      remainingTime.value = workDuration;
    }

    // Yeni seans hazır olduğuna göre, zamanlayıcıyı başlat.
    startOrResumeTimer();
  }
}
