import 'dart:ui';

/// supported languages
enum Language {
  /// English
  english('en', 'US'),

  /// Bengali
  bengali('bn', 'IN'),

  /// Kannada
  kannada('kn', 'IN'),

  /// Hindi
  hindi('hi', 'IN');

  const Language(this.code, this.countryCode);

  /// language code
  final String code;

  /// country code
  final String countryCode;

  /// Converts the Language to a Locale
  Locale get locale => Locale(code, countryCode);

  /// Converts a string to a Language
  static Language fromString(String value) {
    switch (value) {
      case 'en':
        return Language.english;
      case 'bn':
        return Language.bengali;
      case 'kn':
        return Language.kannada;
      case 'hi':
        return Language.hindi;
      default:
        return Language.english;
    }
  }
}
