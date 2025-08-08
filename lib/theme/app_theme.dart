import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData customTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.toastedPeach,
  scaffoldBackgroundColor: AppColors.vanillaMonlight,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.toastedPeach,
    primary: AppColors.toastedPeach,
    secondary: AppColors.toastedPeach,
    surface: AppColors.vanillaMonlight,
    onPrimary: AppColors.vanillaMonlight,
    onSecondary: AppColors.velvetCharcoal,
    onSurface: AppColors.velvetCharcoal,
  
  ),

  dividerColor: Colors.transparent,
  // Cssico, acolhedor
  textTheme: GoogleFonts.loraTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w800,
        color: AppColors.velvetCharcoal,
        fontSize: 32,
      ),

      headlineSmall: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.velvetCharcoal,
        fontSize: 24,
      ),

      bodyLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.velvetCharcoal,
        fontSize: 18,
      ),

      bodyMedium: TextStyle(
        fontWeight: FontWeight.normal,
        color: AppColors.velvetCharcoal,
        fontSize: 16,
      ),

      bodySmall: TextStyle(
        fontWeight: FontWeight.normal,
        color: AppColors.velvetCharcoal,
        fontSize: 14,
      ),

      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.velvetCharcoal,
        fontSize: 22,
      ),

      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.velvetCharcoal,
        fontSize: 18,
      ),

      titleSmall: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.velvetCharcoal,
        fontSize: 16,
      ),

      labelLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.velvetCharcoal,
        fontSize: 14,
      ),

      labelMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.velvetCharcoal,
        fontSize: 12,
      ),

      labelSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.velvetCharcoal,
        fontSize: 10,
      ),
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,

    iconTheme: IconThemeData(color: AppColors.velvetCharcoal),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColors.vanillaMonlight, // Mais suave ainda
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.toastedPeach,
      foregroundColor: AppColors.vanillaMonlight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: TextStyle(fontSize: 16),
    ),
  ),
);
