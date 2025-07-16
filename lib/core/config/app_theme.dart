import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6D5FFF),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge:
          const TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
      titleLarge: const TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic),
      bodyMedium: const TextStyle(fontSize: 14.0),
    ),
    cardTheme: CardTheme(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black.withOpacity(0.08),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.12),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF6D5FFF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF6D5FFF), width: 2),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6D5FFF),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme:
        GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge:
          const TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
      titleLarge: const TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic),
      bodyMedium: const TextStyle(fontSize: 14.0),
    ),
    cardTheme: CardTheme(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black.withOpacity(0.16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.18),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF6D5FFF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF6D5FFF), width: 2),
      ),
    ),
  );
}
