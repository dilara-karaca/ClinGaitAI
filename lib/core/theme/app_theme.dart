import 'package:flutter/material.dart';

class AppColors {
  // Ana renkler - Sağlık / medikal teması
  static const Color primary = Color(0xFF2E7D8C); // Koyu teal
  static const Color primaryLight = Color(0xFF4DA8B8); // Açık teal
  static const Color primaryDark = Color(0xFF1A5C6A); // Çok koyu teal
  static const Color secondary = Color(0xFF6EC5B8); // Mint yeşili
  static const Color accent = Color(0xFFFF8A65); // Turuncu vurgu

  // Arka plan renkleri
  static const Color background = Color(0xFFF5F9FA); // Açık gri-mavi
  static const Color surface = Color(0xFFFFFFFF); // Beyaz
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Metin renkleri
  static const Color textPrimary = Color(0xFF1A2B3C); // Koyu lacivert
  static const Color textSecondary = Color(0xFF6B7B8D); // Gri
  static const Color textLight = Color(0xFF9EAAB6); // Açık gri

  // Durum renkleri
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF42A5F5);

  // Grafik renkleri
  static const Color chartBlue = Color(0xFF42A5F5);
  static const Color chartGreen = Color(0xFF66BB6A);
  static const Color chartOrange = Color(0xFFFFA726);
  static const Color chartPurple = Color(0xFFAB47BC);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E6EA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E6EA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
