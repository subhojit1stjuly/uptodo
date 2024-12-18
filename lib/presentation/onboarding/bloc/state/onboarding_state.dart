import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/presentation/onboarding/bloc/onboard_model.dart';

part 'onboarding_state.freezed.dart';

/// state for the Onboarding Bloc
@freezed
class OnboardingState with _$OnboardingState {
  /// this State will be emitted when user clicks on the skip button
  /// or clicks get started
  const factory OnboardingState.welcome() = WelComeState;

  /// or press back in the welcomes screen
  const factory OnboardingState.onboard({
    required List<OnboardModel> data,
  }) = OnboardState;

  /// this state is emitted when user clicks on next button
  const factory OnboardingState.change(int pageNo) = ChangeState;
}
