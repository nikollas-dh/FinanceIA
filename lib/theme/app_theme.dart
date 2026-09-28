import 'package:flutter/material.dart';

class AppTheme {
  static const verde = Color(0xFF1B8A5A);
  static const vermelho = Color(0xFFD64545);

  static final ThemeData tema = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: verde),
    scaffoldBackgroundColor: const Color(0xFFF4F7F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: verde,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: verde,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
