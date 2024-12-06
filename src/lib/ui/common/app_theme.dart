import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: kcPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: kcPrimaryColor,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kcPrimaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kcPrimaryColor,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: kcPrimaryColor,
        secondary: kcPrimaryColorDark,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: kcPrimaryColor,
      scaffoldBackgroundColor: kcDarkGreyColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: kcDarkGreyColor,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: kcMediumGrey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kcPrimaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kcPrimaryColor,
        ),
      ),
      colorScheme: ColorScheme.dark().copyWith(
        primary: kcPrimaryColor,
        secondary: kcPrimaryColorDark,
      ),
    );
  }
}
