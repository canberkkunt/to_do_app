import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final _baseTextStyle = GoogleFonts.sourceSans3TextTheme;
  static final _appBarTextStyle = GoogleFonts.playfairDisplayTextTheme;

  // =======================================================================
  // 1. VARSAYILAN KOYU TEMA
  // =======================================================================
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.blueAccent,
      secondary: Colors.redAccent,
      background: Colors.grey.shade900,
      surface: Colors.grey.shade800,
      error: Colors.red.shade400,
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      elevation: 0,
      // DÜZELTME: 'Playfair Display' kullanıyoruz.
      titleTextStyle: _appBarTextStyle(
        ThemeData.dark().textTheme,
      ).titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
      color: Colors.grey.shade800,
      elevation: 8,
    ),
    // ... (diğer temalar aynı kalıyor)
    // DÜZELTME: Genel metin fontunu 'Source Sans 3' yapıyoruz.
    textTheme: _baseTextStyle(ThemeData.dark().textTheme),
  );

  // =======================================================================
  // 2. AYDINLIK TEMA
  // =======================================================================
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.redAccent,
      background: Colors.grey.shade100,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      titleTextStyle: _appBarTextStyle(
        ThemeData.light().textTheme,
      ).titleLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Colors.white,
      elevation: 8,
    ),
    // ...
    textTheme: _baseTextStyle(ThemeData.light().textTheme),
  );

  // Diğer temalar için de aynı güncellemeleri yapabiliriz.
  // Örnek olarak Gece Mavisi Teması:
  // =======================================================================
  // 3. GECE MAVİSİ TEMASI
  // =======================================================================
  static final ThemeData blueTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.lightBlueAccent,
      secondary: Colors.amber,
      background: const Color(0xFF0A192F),
      surface: const Color(0xFF172A46),
    ),
    scaffoldBackgroundColor: const Color(0xFF0A192F),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF0A192F),
      elevation: 0,
      titleTextStyle: _appBarTextStyle(
        ThemeData.dark().textTheme,
      ).titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFF172A46),
      elevation: 8,
    ),
    // ...
    textTheme: _baseTextStyle(ThemeData.dark().textTheme),
  );

  // =======================================================================
  // 4. SEPYA / KİTAP OKUYUCU TEMASI
  // =======================================================================
  // 4. SEPYA / KİTAP OKUYUCU TEMASI (GÜNCELLENMİŞ)
  // =======================================================================
  static final ThemeData sepiaTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.brown.shade700,
      secondary: Colors.deepOrange,
      background: const Color(0xFFFBF0D9),
      surface: const Color(0xFFFFF8E1),
    ),
    scaffoldBackgroundColor: const Color(0xFFFBF0D9),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFBF0D9),
      elevation: 0,
      // DÜZELTME: Artık merkezi 'Playfair Display' stilini kullanıyor.
      titleTextStyle: _appBarTextStyle(ThemeData.light().textTheme).titleLarge
          ?.copyWith(
            color:
                Colors.brown.shade900, // Rengi bu temaya özel olarak eziyoruz.
            fontWeight: FontWeight.bold,
          ),
      iconTheme: IconThemeData(color: Colors.brown.shade800),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFFFFF8E1),
      elevation: 8,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.brown.shade800,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFFFFF8E1),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
    ),
    // DÜZELTME: Genel metin fontu artık merkezi 'Source Sans 3' ve rengi temaya özel.
    textTheme: _baseTextStyle(ThemeData.light().textTheme).apply(
      bodyColor: Colors.brown.shade900,
      displayColor: Colors.brown.shade900,
    ),
  );

  // =======================================================================
  // 5. NEON / SYNTHWAVE TEMASI (GÜNCELLENMİŞ)
  // =======================================================================
  static final ThemeData neonTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.cyanAccent,
      secondary: Colors.pinkAccent,
      background: const Color(0xFF1A1A2E),
      surface: const Color(0xFF2C2C54),
    ),
    scaffoldBackgroundColor: const Color(0xFF1A1A2E),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1A1A2E),
      elevation: 0,
      // DÜZELTME: Artık merkezi 'Playfair Display' stilini kullanıyor.
      titleTextStyle: _appBarTextStyle(ThemeData.dark().textTheme).titleLarge
          ?.copyWith(
            color: Colors.cyanAccent, // Rengi bu temaya özel olarak eziyoruz.
            fontWeight: FontWeight.bold,
          ),
      iconTheme: const IconThemeData(color: Colors.cyanAccent),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFF2C2C54),
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.pinkAccent,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2C2C54),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.pinkAccent.withOpacity(0.5)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
    ),
    // DÜZELTME: Genel metin fontu artık merkezi 'Source Sans 3'.
    textTheme: _baseTextStyle(ThemeData.dark().textTheme),
  );
}
