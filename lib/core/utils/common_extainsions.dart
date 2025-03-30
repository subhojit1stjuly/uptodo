import 'package:flutter/material.dart';

/// some common string extensions
extension StringExtainsion on String {
  /// Convert a string to a Color
  IconData getIconFromCodePoint() {
    // Parse the codePoint string to an integer
    final codePoint = int.parse(this);

    // Create an IconData with the codePoint and material icons font family
    return IconData(
      codePoint,
      fontFamily: 'MaterialIcons',
    );
  }
}
