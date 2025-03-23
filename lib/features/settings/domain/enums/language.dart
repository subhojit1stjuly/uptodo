import 'dart:ui';

/// supported languages
enum Language {
  /// English
  english('en'),

  /// Bengali
  bengali('bn'),

  /// Kannada
  kannada('kn'),

  /// Hindi
  hindi('hi');

  const Language(this.code);

  /// language code
  final String code;

  /// Converts the Language to a Locale
  Locale get locale => Locale(code);

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
