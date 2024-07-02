import 'package:flutter/material.dart';

const TextStyle globalLightTextStyle = TextStyle(
  color: Colors.black87,
);
final lightTheme = ThemeData(
  fontFamily: 'Lato',
  splashColor: Colors.white70,
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: Colors.white70,
  textTheme: TextTheme(
    displayLarge: globalLightTextStyle.copyWith(
      fontSize: 32.0,
    ),
    bodyLarge: globalLightTextStyle.copyWith(
      fontSize: 16.0,
    ),
    bodyMedium: globalLightTextStyle.copyWith(
      fontSize: 20.0,
    ),
    bodySmall: globalLightTextStyle.copyWith(
      fontSize: 14.0,
    ),
    labelSmall: globalLightTextStyle.copyWith(
      fontSize: 12.0,
    ),
    labelLarge: globalLightTextStyle.copyWith(
      fontSize: 16.0,
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
        fontSize: 16.0,
        color: Colors.white70,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Radius value
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF8875FF),
      backgroundColor: Colors.transparent,
      textStyle: globalLightTextStyle.copyWith(fontSize: 16.0),
      shadowColor: const Color(0x1A8875FF), // Light shade
    ),
  ),
  inputDecorationTheme:InputDecorationTheme(
    labelStyle: globalLightTextStyle.copyWith(
      fontSize: 16.0,
    ),
    hintStyle: globalLightTextStyle.copyWith(
      fontSize: 14.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black87,
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.white70,
);
