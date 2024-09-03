import 'package:flutter/material.dart';
/// this field is created since we are using it on later stages
const TextStyle globalDarkTextStyle = TextStyle(
  fontFamily: 'Lato',
  color: Colors.white70,
);
/// object for the dark themes
final darkTheme = ThemeData(
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
      fontSize: 16,
    ),
    bodyMedium: globalDarkTextStyle.copyWith(
      fontSize: 20,
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
        borderRadius: BorderRadius.circular(12), // Radius value
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
);
