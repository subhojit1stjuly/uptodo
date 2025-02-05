/// User preference type enum
enum UserPreferenceType {
  /// Theme mode
  themeMode,

  /// Language
  language,

  /// Sync email
  syncEmail,

  /// Has seen onboarding
  hasSeenOnboarding,
}

/// User preference type extension
extension UserPreferenceTypeExtension on UserPreferenceType {
  /// Converts the UserPreferenceType to a string
  String get value {
    switch (this) {
      case UserPreferenceType.themeMode:
        return 'ThemeMode';
      case UserPreferenceType.language:
        return 'Language';
      case UserPreferenceType.syncEmail:
        return 'SyncEmail';
      case UserPreferenceType.hasSeenOnboarding:
        return 'HasSeenOnboarding';
    }
  }

  /// Converts a string to a UserPreferenceType
  static UserPreferenceType fromString(String value) {
    switch (value) {
      case 'ThemeMode':
        return UserPreferenceType.themeMode;
      case 'Language':
        return UserPreferenceType.language;
      case 'SyncEmail':
        return UserPreferenceType.syncEmail;
      case 'HasSeenOnboarding':
        return UserPreferenceType.hasSeenOnboarding;
      default:
        throw Exception('Unknown UserPreferenceType: $value');
    }
  }
}
