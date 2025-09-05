import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/theme/app_themes.dart';

class ThemeController extends GetxController {
  // --- 1. DEĞİŞKENLER (HAFIZA) ---

  // GetStorage kutusuna erişim. Bu bizim "not defterimiz".
  final _box = GetStorage();

  // Diske yazarken kullanacağımız anahtar. Bunu bir değişkende tutmak,
  // yazım hatası yapma riskini azaltır.
  final _key = 'theme';
  final _languageKey = 'language';

  // O anki aktif temanın adını tutan reaktif değişken.
  // '.obs' sayesinde, bu değişken değiştiğinde Obx widget'ları tetiklenir.
  // Başlangıç değeri olarak 'dark' atıyoruz.
  final RxString _currentTheme = 'dark'.obs;

  // Bu bir "getter". Sınıfın dışından birinin _currentTheme'i doğrudan değiştirmesini
  // engeller, ama değerini okumasına izin verir. Daha güvenli bir yöntemdir.
  // Örneğin, SettingsPage'de controller.currentTheme diyerek 'dark' string'ini alabiliriz.
  String get currentTheme => _currentTheme.value;
  final RxString _currentLanguage = 'tr_TR'.obs;
  String get currentLanguage => _currentLanguage.value;

  // --- 2. BAŞLANGIÇ NOKTASI (onInit) ---

  @override
  void onInit() {
    super.onInit();
    // Bu metot, ThemeController ilk oluşturulduğunda SADECE BİR KERE çalışır.
    // Tek görevi, "Uygulama yeni başladı, kayıtlı bir tema var mı bir bak" komutunu vermektir.
    loadTheme();
    loadLanguage();
  }

  // --- 3. FONKSİYONLAR (GÖREVLER) ---

  /// Görev 1: Kayıtlı Temayı Yükle
  void loadTheme() {
    // Not defterini (_box) aç ve içinde '_key' (yani 'theme') ile kaydedilmiş bir şey var mı diye oku.
    // ?? 'dark' operatörü:
    // EĞER _box.read(_key) bir değer bulursa (örn: 'light'), savedTheme = 'light' olur.
    // EĞER _box.read(_key) hiçbir şey bulamazsa (null dönerse, yani uygulama ilk kez açılıyorsa),
    // o zaman varsayılan olarak 'dark' değerini kullan.
    String savedTheme = _box.read(_key) ?? 'dark';

    // Şimdi, diskten okuduğumuz veya varsayılan olarak belirlediğimiz bu temayı
    // uygulamak için ana değiştirme fonksiyonumuzu çağırıyoruz.
    changeTheme(savedTheme);
  }

  /// Görev 2: Temayı Değiştir ve Kaydet
  /// Bu fonksiyon, SettingsPage'deki butonlara basıldığında çağrılacak.
  void changeTheme(String themeName) {
    // A. Anlık Değişiklik: GetX'e, uygulamanın görsel temasını değiştirmesini söyle.
    // Bunun için önce getThemeData'dan doğru ThemeData nesnesini istiyoruz.
    Get.changeTheme(getThemeData(themeName));

    // B. Durumu Güncelle: Kendi iç hafızamızdaki (_currentTheme) değeri,
    // yeni seçilen tema adıyla güncelliyoruz. Bu, SettingsPage'deki
    // "tik" ikonunun doğru yerde görünmesini sağlar.
    _currentTheme.value = themeName;

    // C. Kalıcı Kayıt: Bu yeni seçimi (_key anahtarıyla) not defterine (_box) yazıyoruz ki,
    // kullanıcı uygulamayı kapatıp açtığında bu seçim hatırlansın.
    _box.write(_key, themeName);
  }

  /// Görev 3: Tema Verisini Sağla
  /// Bu, bir "veri tablosu" veya "katalog" gibidir.
  ThemeData getThemeData(String themeName) {
    // Gelen tema adına göre...
    switch (themeName) {
      case 'light':
        // ... AppThemes sınıfından doğru statik temayı bul ve geri döndür.
        return AppThemes.lightTheme;
      case 'sepia':
        return AppThemes.sepiaTheme;
      case 'neon':
        return AppThemes.neonTheme;
      case 'blue':
        return AppThemes.blueTheme;
      case 'dark':
      default: // Eğer bilinmeyen bir tema adı gelirse, varsayılan olarak bunu döndür.
        return AppThemes.darkTheme;
    }
  }

  void loadLanguage() {
    // 'language' anahtarındaki değeri oku. Bulamazsan 'tr_TR' kullan.
    String savedLanguage = _box.read(_languageKey) ?? 'tr_TR';
    changeLanguage(savedLanguage);
  }

  /// Görev: Dili Değiştir ve Kaydet
  /// Bu fonksiyon, SettingsPage'deki dil butonları tarafından çağrılacak.
  void changeLanguage(String langCode) {
    // langCode'dan (örn: "en_US") bir Locale nesnesi oluşturuyoruz.
    // Dil kodunu '_' karakterinden ayırıyoruz.
    final localeParts = langCode.split('_');
    final locale = Locale(localeParts[0], localeParts[1]);

    // 1. GetX'in dil motorunu yeni dille güncelle.
    // Bu komut, .tr olan tüm widget'ların anında değişmesini sağlar.
    Get.updateLocale(locale);

    // 2. O anki dilin ne olduğunu reaktif değişkende sakla.
    _currentLanguage.value = langCode;

    // 3. Kullanıcının seçimini bir sonraki açılış için diske kaydet.
    _box.write(_languageKey, langCode);
  }
}
