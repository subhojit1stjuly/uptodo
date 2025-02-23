import 'dart:ui';

import 'package:uptodo/features/settings/domain/enums/language.dart';

/// This class contains the supported locales and
/// helper methods to work with locales.
class LocaleConstants {
  /// List of supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('bn', 'IN'), // Bengali
    Locale('kn', 'IN'), // Kannada
    Locale('hi', 'IN'), // Hindi
  ];

  /// Default locale
  static const defaultLocale = Locale('en', 'US');

  /// Check if a locale is supported
  static bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }

  /// Get locale name for display
  static String getLocaleName(Locale locale) {
    final names = {
      Language.english.code: 'English',
      Language.bengali.code: 'বাংলা', // Bengali
      Language.kannada.code: 'ಕನ್ನಡ', // Kannada
      Language.hindi.code: 'हिंदी', // Hindi
    };
    return names[locale.languageCode] ?? locale.languageCode;
  }
}
