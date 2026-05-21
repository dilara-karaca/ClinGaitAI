import 'package:flutter/material.dart';

class AppColors {
  // Canlı Koyu Mavi & Lacivert (Ana Taşıyıcı Renkler)
  static const Color primary = Color(0xFF1E3A8A); // Canlı koyu mavi / lacivert
  static const Color primaryLight = Color(0xFF3B82F6); // Açık canlı mavi
  static const Color primaryDark = Color(0xFF0F172A); // Koyu lacivert (Üst bar, alt menü)
  
  // Koyu Turkuaz
  static const Color secondary = Color(0xFF0891B2); // Koyu turkuaz
  static const Color accent = Color(0xFF0E7490); // Yardımcı koyu turkuaz

  // Arka plan ve kart renkleri (Beyaz tema)
  static const Color background = Color(0xFFFFFFFF); // Saf beyaz arka plan
  static const Color surface = Color(0xFFFFFFFF); // Beyaz
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Metin renkleri
  static const Color textPrimary = Color(0xFF0F172A); // Koyu lacivert/siyah
  static const Color textSecondary = Color(0xFF475569); // Gri daha koyu
  static const Color textLight = Color(0xFF94A3B8); // Açık gri

  // Yeşil Tonları ve Gradyan
  static const Color success = Color(0xFF10B981); // Zümrüt / Başarı yeşili
  static const Color mintGreen = Color(0xFF2DD4BF); // Canlı Mint yeşili
  static const Color sageGreen = Color(0xFF8BA896); // Adaçayı Yeşili
  static const Color sageGreenLight = Color(0xFFE8EFEA); // Hafif adaçayı yeşili (pasif kart ve sınır hatları)
  
  static const List<Color> greenGradient = [
    Color(0xFF065F46), // Koyu yeşil
    Color(0xFF2DD4BF), // Nane yeşili (Mint)
  ];

  // Durum renkleri
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF0891B2); // Koyu turkuaz

  // Grafik renkleri (Geriye dönük uyumluluk için)
  static const Color chartBlue = Color(0xFF0891B2);
  static const Color chartGreen = Color(0xFF2DD4BF);
  static const Color chartOrange = Color(0xFF8BA896);
  static const Color chartPurple = Color(0xFF1E3A8A);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.sageGreenLight, width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        selectedItemColor: AppColors.mintGreen,
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
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.sageGreenLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.sageGreenLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.mintGreen, width: 2),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textLight),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
