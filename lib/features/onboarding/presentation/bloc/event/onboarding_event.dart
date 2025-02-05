import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_event.freezed.dart';

/// Onboarding event for the loc
@freezed
class OnboardingEvent with _$OnboardingEvent {
  /// initializing event
  const factory OnboardingEvent.initialize() = InitializeEvent;

  /// when skip is clicked we will add this event
  const factory OnboardingEvent.skip() = SkippedEvent;

  /// when back button from welcome widget or onboarding widget is clicked
  const factory OnboardingEvent.back() = BackEvent;

  /// when next / Get started button is clicked
  const factory OnboardingEvent.next() = NextEvent;

  /// when previous button is clicked
  const factory OnboardingEvent.previous() = PreviousEvent;

  /// when pageView is scrolled
  const factory OnboardingEvent.change(int pageNo) = ChangeEvent;

  /// when login is pressed in the welcome widget
  const factory OnboardingEvent.loginRedirect() = LoginRedirectEvent;

  /// when create account is pressed in the welcome widget
  const factory OnboardingEvent.createAccount() = CreateAccountEvent;
}
