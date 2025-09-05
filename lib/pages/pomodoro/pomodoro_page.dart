import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/pages/pomodoro/pomodoro_controller.dart';

// DÜZELTME 1: GetView yerine StatefulWidget kullanıyoruz.
// Bu, CountDownController'ın yaşam döngüsünü yönetmemizi sağlar.
class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  // DÜZELTME 2: CountDownController'ı state'in bir parçası yapıyoruz.
  // Artık build metodu her çalıştığında sıfırlanmayacak.
  final CountDownController _countDownController = CountDownController();
  // GetX'in PomodoroController'ına erişim için bir referans oluşturuyoruz.
  final PomodoroController controller = Get.find<PomodoroController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- 1. Durum Başlığı ---
            Obx(
              () => Text(
                _getStatusText(controller.currentState.value),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- 2. Dairesel Sayaç ---
            Obx(
              () => CircularCountDownTimer(
                key: ValueKey(
                  '${controller.currentState.value}_${controller.pomodoroCount.value}',
                ),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
                duration: _getDurationForState(controller.currentState.value),
                initialDuration:
                    (_getDurationForState(controller.currentState.value) -
                    controller.remainingTime.value),
                // DÜZELTME 3: State'e ait olan _countDownController'ı kullanıyoruz.
                controller: _countDownController,
                isReverse: true,
                autoStart: false,
                textFormat: CountdownTextFormat.MM_SS,
                textStyle: TextStyle(
                  fontSize: 52.0,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
                fillColor: Theme.of(context).colorScheme.primary,
                ringColor: Theme.of(context).dividerColor,
              ),
            ),

            const SizedBox(height: 40),

            // --- 3. Kontrol Butonları ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 1. BAŞLAT BUTONU
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 40,
                  color: Theme.of(context).colorScheme.primary,
                  tooltip: 'Başlat',
                  // Koşul kaldırıldı. Her zaman tıklanabilir.
                  onPressed: () {
                    // Not: Controller, zaten çalışıyorsa bir şey yapmayacak.
                    controller.startOrResumeTimer();
                    // Görsel sayacı başlatmayı dene. Zaten başladıysa bir şey olmaz.
                    if (_countDownController.isStarted == true) {
                      _countDownController.start();
                    }
                  },
                ),

                // 2. DEVAM ET BUTONU
                IconButton(
                  icon: const Icon(Icons.play_circle_outline),
                  iconSize: 40,
                  color: Theme.of(context).colorScheme.primary,
                  tooltip: 'Devam Et',
                  // Koşul kaldırıldı. Her zaman tıklanabilir.
                  onPressed: () {
                    controller.startOrResumeTimer();
                    _countDownController.resume();
                  },
                ),

                // 3. DURAKLAT BUTONU
                IconButton(
                  icon: const Icon(Icons.pause),
                  iconSize: 40,
                  color: Theme.of(context).colorScheme.primary,
                  tooltip: 'Duraklat',
                  // Koşul kaldırıldı. Her zaman tıklanabilir.
                  onPressed: () {
                    controller.pauseTimer();
                    _countDownController.pause();
                  },
                ),

                // 4. SIFIRLA BUTONU
                IconButton(
                  icon: const Icon(Icons.stop),
                  iconSize: 40,
                  color: Colors.redAccent,
                  tooltip: 'Sıfırla',
                  // Koşul kaldırıldı. Her zaman tıklanabilir.
                  onPressed: () {
                    controller.resetTimer();
                    _countDownController.restart(
                      duration: controller.workDuration,
                    );
                    _countDownController.pause();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper (yardımcı) metotlar artık sınıfın içinde.
  String _getStatusText(PomodoroState state) {
    switch (state) {
      case PomodoroState.working:
        return "Çalışma Zamanı";
      case PomodoroState.shortBreak:
        return "Kısa Mola";
      case PomodoroState.longBreak:
        return "Uzun Mola";
      case PomodoroState.paused:
        return "Duraklatıldı";
      case PomodoroState.stopped:
        return "Başlamaya Hazır";
      default:
        return "";
    }
  }

  int _getDurationForState(PomodoroState state) {
    switch (state) {
      case PomodoroState.working:
      case PomodoroState.paused:
      case PomodoroState.stopped:
        return controller.workDuration;
      case PomodoroState.shortBreak:
        return controller.shortBreakDuration;
      case PomodoroState.longBreak:
        return controller.longBreakDuration;
    }
  }
}
