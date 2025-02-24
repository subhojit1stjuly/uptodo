import 'dart:ui';

import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/settings/domain/enums/language.dart';

/// service class for the Localization as the data can be used from the
/// blocs, so moving the logic here, so that, there will be no need fo the
/// context to be passed into the bloc

class AppLocalizationsService {
  /// Constructor that accepts `AppLocalizations`
  const AppLocalizationsService(this.localizations);

  /// `AppLocalizations` instance
  final AppLocalizations localizations;

  /// this method will return the tilte for the onboarding screen
  String getOnboardingTitle(int index) {
    switch (index) {
      case 0:
        return localizations.onboarding_title_1;
      case 1:
        return localizations.onboarding_title_2;
      case 2:
        return localizations.onboarding_title_3;
      default:
        return '';
    }
  }

  /// this method will return the description for the onboarding screen
  String getOnboardingDescription(int index) {
    switch (index) {
      case 0:
        return localizations.onboarding_desc_1;
      case 1:
        return localizations.onboarding_desc_2;
      case 2:
        return localizations.onboarding_desc_3;
      default:
        return '';
    }
  }

  /// Skip text
  String get skip => localizations.button_skip;

  /// Returns the name of the language based on the Locale
  String getLocaleName(Locale locale) {
    final names = {
      Language.english.code: 'English',
      Language.bengali.code: 'বাংলা', // Bengali
      Language.kannada.code: 'ಕನ್ನಡ', // Kannada
      Language.hindi.code: 'हिंदी', // Hindi
    };
    return names[locale.languageCode] ?? locale.languageCode;
  }
}
