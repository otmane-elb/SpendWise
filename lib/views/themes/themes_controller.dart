import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class ThemesController {
  static ThemeData get getLightTheme {
    return ThemeData(
      textTheme: TextTheme(
        titleMedium: GoogleFonts.inter().copyWith(
            fontSize: 50, color: AppColors.white, fontWeight: FontWeight.bold),
        titleSmall: GoogleFonts.inter().copyWith(
            fontSize: 36,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.inter().copyWith(
            fontSize: 22, color: AppColors.white, fontWeight: FontWeight.bold),
        bodyMedium: GoogleFonts.inter().copyWith(
            fontSize: 14, color: AppColors.white, fontWeight: FontWeight.w500),
        labelLarge: GoogleFonts.inter().copyWith(
            fontSize: 20, color: AppColors.white, fontWeight: FontWeight.bold),
        labelSmall: GoogleFonts.inter().copyWith(
            fontSize: 16, color: AppColors.beige, fontWeight: FontWeight.w500),
        titleLarge: GoogleFonts.inter().copyWith(
            fontSize: 18, color: AppColors.black, fontWeight: FontWeight.w600),
      ),
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(
        primary: AppColors.primaryColor,
        seedColor: AppColors.white,
        onPrimary: AppColors.white,
        secondary: AppColors.white,
        onSecondary: AppColors.white,
        primaryContainer: AppColors.white,
        surfaceVariant: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        fillColor: AppColors.white,
        filled: true,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.grey400,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => const Icon(
          Icons.chevron_left,
          color: AppColors.white,
          size: 35,
        ),
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
        color: AppColors.white,
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      dialogBackgroundColor: AppColors.white,
      dialogTheme: const DialogTheme(
        surfaceTintColor: AppColors.white,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(surfaceTintColor: Colors.white),
    );
  }
}
