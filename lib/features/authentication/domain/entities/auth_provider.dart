/// Represents the available authentication providers in the application
enum AuthProvider {
  /// Google OAuth authentication
  google,

  /// Apple Sign In authentication
  apple,

  /// Facebook OAuth authentication
  facebook,

  /// Email & Password authentication
  email,

  /// Phone number authentication
  phone;

  /// Returns true if the provider requires OAuth flow
  bool get isOAuth => this == google || this == apple || this == facebook;

  /// Returns true if the provider is email-based
  bool get isEmail => this == email;

  /// Returns true if the provider is phone-based
  bool get isPhone => this == phone;
}
