import 'package:flutter/material.dart';

/// This extension is used to convert the ThemeMode to a string
extension ThemeModeExtension on ThemeMode {
  /// Converts the ThemeMode to a string
  String get value {
    switch (this) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  /// Converts a string to a ThemeMode
  static ThemeMode fromString(String value) {
    switch (value) {
      case 'System':
        return ThemeMode.system;
      case 'Light':
        return ThemeMode.light;
      case 'Dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
