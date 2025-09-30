import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212), // Background
    primaryColor: const Color(0xFFE63946), // Primary
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Color(0xFFF5F5F7), // Text
      elevation: 0,
    ),
    textTheme: GoogleFonts.comfortaaTextTheme().apply(
      bodyColor: const Color(0xFFF5F5F7),
      displayColor: const Color(0xFFF5F5F7),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Color(0xFFFFB703), // Active
      unselectedItemColor: Color(0xFF6E6E73), // Inactive
    ),
    dividerColor: Colors.white24,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFE63946),
      secondary: Color(0xFFFFB703),
      onPrimary: Colors.white,
      surface: Color(0xFF121212),
      onSurface: Color(0xFFF5F5F7),
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFF8F0), // Background
    primaryColor: const Color(0xFFE63946), // Primary
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFF8F0),
      foregroundColor: Color(0xFF1D1D1F), // Text
      elevation: 0,
    ),
    textTheme: GoogleFonts.comfortaaTextTheme().apply(
      bodyColor: const Color(0xFF1D1D1F),
      displayColor: const Color(0xFF1D1D1F),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFF8F0),
      selectedItemColor: Color(0xFFE63946), // Active
      unselectedItemColor: Color(0xFF8E8E93), // Inactive
    ),
    dividerColor: Colors.black12,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFE63946),
      secondary: Color(0xFFFFB703),
      onPrimary: Colors.white,
      surface: Color(0xFFFFF8F0),
      onSurface: Color(0xFF1D1D1F),
    ),
  );
}
