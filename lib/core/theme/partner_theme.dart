import 'package:flutter/material.dart';

class PartnerTheme {
  // Brand Palette - Executive Midnight Emerald & Gold
  static const Color background = Color(0xFF070D12);
  static const Color surface = Color(0xFF0F1A22);
  static const Color surfaceCard = Color(0xFF142430);
  static const Color surfaceElevated = Color(0xFF1D3243);
  static const Color border = Color(0xFF253E52);

  // Accents
  static const Color primaryGold = Color(0xFFFFB800);
  static const Color emeraldGreen = Color(0xFF10B981);
  static const Color cyanAccent = Color(0xFF06B6D4);
  static const Color crimsonRed = Color(0xFFEF4444);

  // Semantic
  static const Color successGreen = emeraldGreen;
  static const Color alertRed = crimsonRed;

  // Text
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        secondary: emeraldGreen,
        surface: surface,
        error: crimsonRed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}
