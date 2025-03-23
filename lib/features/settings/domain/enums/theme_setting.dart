/// [ThemeSetting] is an enum class that
/// contains the theme settings.
enum ThemeSetting {
  /// Dark theme
  dark('dark'),

  /// Light theme
  light('light'),

  /// System theme
  system('system');

  const ThemeSetting(this.code);

  /// Theme code
  final String code;
}
