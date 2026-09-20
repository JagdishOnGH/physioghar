import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF2F5D50);
  static const Color secondary = Color(0xFF3F7965);
  static const Color bgLight = Color(0xFFD1E8DF);
  static const Color bgNeutral = Color(0xFFEEF1ED);
  static const Color accent = Color(0xFFE2962F);
  static const Color accentPale = Color(0xFFFBEFD9);
  static const Color bgMain = Color(0xFFFBFBF8);
  static const Color textPrimary = Color(0xFF1E2A2E);
  static const Color textSecondary = Color(0xFF4A5854);
  static const Color textMuted = Color(0xFF8FA8A0);
  static const Color error = Color(0xFFC84B4B);
  static const Color errorBg = Color(0xFFFCE8E8);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bgMain,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.bgMain,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE8ECE9), width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgMain,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.fraunces(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: GoogleFonts.fraunces(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.fraunces(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          color: AppColors.textMuted,
        ),
        labelLarge: GoogleFonts.ibmPlexMono(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: AppColors.textSecondary,
        ),
        labelMedium: GoogleFonts.ibmPlexMono(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: AppColors.textMuted,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.bgLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD6E2DD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(44, 48),
          shape: const StadiumBorder(),
          elevation: 0,
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
