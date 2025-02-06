import 'dart:ui';

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

  /// You can also add helper methods if needed
  static bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }

  /// Get locale name for display
  static String getLocaleName(Locale locale) {
    final names = {
      'en': 'English',
      'bn': 'বাংলা', // Bengali
      'kn': 'ಕನ್ನಡ', // Kannada
      'hi': 'हिंदी', // Hindi
    };
    return names[locale.languageCode] ?? locale.languageCode;
  }
}
