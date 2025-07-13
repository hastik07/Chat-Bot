import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF0A0A1A);
  static const Color surface = Color(0xFF18182C);
  static const Color neonPurple = Color(0xFFB16DFF);
  static const Color neonPink = Color(0xFFFF4EDB);
  static const Color neonBlue = Color(0xFF4EDBFF);
  static const Color accent = neonPurple;
  static const Color glass = Color(0x33FFFFFF);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0C3);
}

ThemeData get appThemeDark => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.dark(
    primary: AppColors.neonPurple,
    secondary: AppColors.neonPink,
    surface: AppColors.surface,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
  ),
  textTheme: GoogleFonts.montserratTextTheme().copyWith(
    displayLarge: GoogleFonts.montserrat(
      fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 16, color: AppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14, color: AppColors.textSecondary,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.neonPink,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      backgroundColor: AppColors.neonPurple,
      foregroundColor: Colors.white,
      textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
      elevation: 0,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      side: const BorderSide(color: AppColors.neonPink, width: 2),
      foregroundColor: AppColors.neonPink,
      textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.surface.withValues(alpha: 0.8),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    shadowColor: AppColors.neonBlue.withValues(alpha: 0.2),
    margin: const EdgeInsets.all(12),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface.withValues(alpha: 0.7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.neonBlue.withValues(alpha: 0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.neonPink, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.neonPurple.withValues(alpha: 0.5)),
    ),
    hintStyle: GoogleFonts.montserrat(color: AppColors.textSecondary),
    labelStyle: GoogleFonts.montserrat(color: AppColors.neonPink),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
    ),
    iconTheme: const IconThemeData(color: AppColors.neonPink),
  ),
); 