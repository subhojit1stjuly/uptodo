import 'package:flutter/material.dart';

/// this field is created since we are using it on later stages
const TextStyle globalDarkTextStyle = TextStyle(
  fontFamily: 'Lato',
  color: Colors.white,
);

/// object for the dark themes
final darkTheme = ThemeData(
  primaryColorDark: const Color(0xFF8875FF),
  fontFamily: 'Lato',
  splashColor: Colors.black87,
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: Colors.black87,
  textTheme: TextTheme(
    displayLarge: globalDarkTextStyle.copyWith(
      fontSize: 32,
    ),
    bodyLarge: globalDarkTextStyle.copyWith(
      fontSize: 20,
    ),
    bodyMedium: globalDarkTextStyle.copyWith(
      fontSize: 16,
    ),
    bodySmall: globalDarkTextStyle.copyWith(
      fontSize: 14,
    ),
    labelSmall: globalDarkTextStyle.copyWith(
      fontSize: 12,
    ),
    labelLarge: globalDarkTextStyle.copyWith(
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
      textStyle: globalDarkTextStyle.copyWith(
        fontSize: 16,
        color: Colors.white70,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Radius value
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white70,
      backgroundColor: Colors.transparent,
      textStyle: globalDarkTextStyle.copyWith(fontSize: 16),
      shadowColor: const Color(0x1AFFFFFF), // Light shade
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white70, // Text and icon color
      side: const BorderSide(color: Color(0xFF8875FF)), // Outline color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Radius value
      ),
      shadowColor: const Color(0x1AFFFFFF),
      textStyle: globalDarkTextStyle.copyWith(fontSize: 16),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: globalDarkTextStyle.copyWith(
      fontSize: 16,
    ),
    hintStyle: globalDarkTextStyle.copyWith(
      fontSize: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white70,
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.black87,
  iconTheme: const IconThemeData(
    color: Colors.white,
    size: 18,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,
  ),
);
