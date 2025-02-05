import 'package:flutter/material.dart';

/// global style which is used in the later stages
const TextStyle globalLightTextStyle = TextStyle(
  color: Colors.black87,
);

/// object for the light theme used in the main
final lightTheme = ThemeData(
  primaryColorLight: const Color(0xFF8875FF),
  fontFamily: 'Lato',
  splashColor: Colors.white70,
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: Colors.white70,
  textTheme: TextTheme(
    displayLarge: globalLightTextStyle.copyWith(
      fontSize: 32,
    ),
    bodyLarge: globalLightTextStyle.copyWith(
      fontSize: 20,
    ),
    bodyMedium: globalLightTextStyle.copyWith(
      fontSize: 16,
    ),
    bodySmall: globalLightTextStyle.copyWith(
      fontSize: 14,
    ),
    labelSmall: globalLightTextStyle.copyWith(
      fontSize: 12,
    ),
    labelLarge: globalLightTextStyle.copyWith(
      fontSize: 16,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.transparent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white70,
      backgroundColor: const Color(0xFF8875FF),
      textStyle: globalLightTextStyle.copyWith(
        fontSize: 16,
        color: Colors.white70,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Radius value
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF8875FF),
      backgroundColor: Colors.transparent,
      textStyle: globalLightTextStyle.copyWith(fontSize: 16),
      shadowColor: const Color(0x1A8875FF), // Light shade
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF8875FF), // Text and icon color
      side: const BorderSide(color: Color(0xFF8875FF)), // Outline color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Radius value
      ),
      shadowColor: const Color(0x1AFFFFFF),
      textStyle: globalLightTextStyle.copyWith(fontSize: 16),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: globalLightTextStyle.copyWith(
      fontSize: 16,
    ),
    hintStyle: globalLightTextStyle.copyWith(
      fontSize: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black87,
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black87,
    size: 18,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
);
