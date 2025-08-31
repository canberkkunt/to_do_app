import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // =======================================================================
  // 1. VARSAYILAN KOYU TEMA
  // =======================================================================
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.blueAccent,
      secondary: Colors.redAccent,
      background: Colors.grey.shade900,
      surface: Colors
          .grey
          .shade800, // Card ve BottomAppBar için bu rengi kullanacağız
      error: Colors.red.shade400,
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      elevation: 0,
      titleTextStyle: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
      color: Colors.grey.shade800, // <<< YENİ EKLENEN KISIM
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      color: Colors.grey.shade800,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    ),
    textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
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
      surface: Colors.white, // Card ve BottomAppBar için bu rengi kullanacağız
    ),
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade100,
      elevation: 1,
      titleTextStyle: GoogleFonts.lato(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Colors.white, // <<< YENİ EKLENEN KISIM
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    ),
    textTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme),
  );

  // =======================================================================
  // 3. GECE MAVİSİ TEMASI
  // =======================================================================
  static final ThemeData blueTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.lightBlueAccent,
      secondary: Colors.amber,
      background: const Color(0xFF0A192F),
      surface: const Color(
        0xFF172A46,
      ), // Card ve BottomAppBar için bu rengi kullanacağız
    ),
    scaffoldBackgroundColor: const Color(0xFF0A192F),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF0A192F),
      elevation: 0,
      titleTextStyle: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFF172A46), // <<< YENİ EKLENEN KISIM
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF172A46),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
    ),
    textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
  );

  // =======================================================================
  // 4. SEPYA / KİTAP OKUYUCU TEMASI
  // =======================================================================
  static final ThemeData sepiaTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.brown.shade700,
      secondary: Colors.deepOrange,
      background: const Color(0xFFFBF0D9),
      surface: const Color(
        0xFFFFF8E1,
      ), // Card ve BottomAppBar için bu rengi kullanacağız
    ),
    scaffoldBackgroundColor: const Color(0xFFFBF0D9),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFBF0D9),
      elevation: 0,
      titleTextStyle: GoogleFonts.lato(
        color: Colors.brown.shade900,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.brown.shade800),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFFFFF8E1), // <<< YENİ EKLENEN KISIM
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
    textTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: Colors.brown.shade900,
      displayColor: Colors.brown.shade900,
    ),
  );

  // =======================================================================
  // 5. NEON / SYNTHWAVE TEMASI
  // =======================================================================
  static final ThemeData neonTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.cyanAccent,
      secondary: Colors.pinkAccent,
      background: const Color(0xFF1A1A2E),
      surface: const Color(
        0xFF2C2C54,
      ), // Card ve BottomAppBar için bu rengi kullanacağız
    ),
    scaffoldBackgroundColor: const Color(0xFF1A1A2E),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1A1A2E),
      elevation: 0,
      titleTextStyle: GoogleFonts.lato(
        color: Colors.cyanAccent,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.cyanAccent),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFF2C2C54), // <<< YENİ EKLENEN KISIM
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
    textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
  );
}
