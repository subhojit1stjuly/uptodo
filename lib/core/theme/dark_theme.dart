import 'package:flutter/material.dart';

const TextStyle globalDarkTextStyle = TextStyle(
  fontFamily: 'Lato',
  color: Colors.white70,
);
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
      fontSize: 16.0,
    ),
    bodyMedium: globalDarkTextStyle.copyWith(
      fontSize: 20.0,
    ),
    bodySmall: globalDarkTextStyle.copyWith(
      fontSize: 14.0,
    ),
    labelSmall: globalDarkTextStyle.copyWith(
      fontSize: 12.0,
    ),
    labelLarge: globalDarkTextStyle.copyWith(
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
      textStyle: globalDarkTextStyle.copyWith(
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
      foregroundColor: Colors.white70,
      backgroundColor: Colors.transparent,
      textStyle: globalDarkTextStyle.copyWith(fontSize: 16.0),
      shadowColor: const Color(0x1AFFFFFF), // Light shade
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: globalDarkTextStyle.copyWith(
      fontSize: 16.0,
    ),
    hintStyle: globalDarkTextStyle.copyWith(
      fontSize: 14.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white70,
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.black87,
);
