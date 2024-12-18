import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uptodo/presentation/onboarding/bloc/event/onboarding_event.dart';
import 'package:uptodo/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:uptodo/presentation/onboarding/bloc/state/onboarding_state.dart';

import '../../../mocks/miscellaneous_mocks.mocks.dart';


void main() {
  late OnboardingBloc onboardingBloc;
  late MockAppLocalizationsService localizationsService;

  setUp(() {
    localizationsService = MockAppLocalizationsService();
    when(localizationsService.getOnboardingTitle(any)).thenReturn('Title');
    when(localizationsService.getOnboardingDescription(any))
        .thenReturn('Description');
    onboardingBloc = OnboardingBloc(localizationsService: localizationsService);
  });

  blocTest<OnboardingBloc, OnboardingState>(
    'emits [OnboardingState.change(0)] when InitializeEvent is added',
    build: () => onboardingBloc,
    act: (bloc) => bloc.add(const InitializeEvent()),
    expect: () => [const OnboardingState.change(0)],
  );

  blocTest<OnboardingBloc, OnboardingState>(
    'emits [WelComeState] when SkippedEvent is added',
    build: () => onboardingBloc,
    act: (bloc) => bloc.add(const SkippedEvent()),
    expect: () => [const WelComeState()],
  );

  blocTest<OnboardingBloc, OnboardingState>(
    'emits previous state when BackEvent is added',
    build: () => onboardingBloc,
    seed: () => const OnboardingState.change(2),
    act: (bloc) => bloc.add(const BackEvent()),
    expect: () => [isA<OnboardState>()],
  );

  blocTest<OnboardingBloc, OnboardingState>(
    'emits next state when NextEvent is added',
    build: () => onboardingBloc,
    seed: () => const OnboardingState.change(0),
    act: (bloc) => bloc.add(const NextEvent()),
    expect: () => [const OnboardingState.change(1)],
  );

  blocTest<OnboardingBloc, OnboardingState>(
    'emits WelComeState when NextEvent is added on the last page',
    build: () => onboardingBloc,
    seed: () => const OnboardingState.change(2),
    act: (bloc) => bloc.add(const NextEvent()),
    expect: () => [const WelComeState()],
  );

  blocTest<OnboardingBloc, OnboardingState>(
    'emits previous state when PreviousEvent is added',
    build: () => onboardingBloc,
    seed: () => const OnboardingState.change(1),
    act: (bloc) => bloc.add(const PreviousEvent()),
    expect: () => [const OnboardingState.change(0)],
  );

  blocTest<OnboardingBloc, OnboardingState>(
    'emits specified page state when ChangeEvent is added',
    build: () => onboardingBloc,
    act: (bloc) => bloc.add(const OnboardingEvent.change(1)),
    expect: () => [const OnboardingState.change(1)],
  );

  // Add tests for LoginRedirectEvent and CreateAccountEvent as needed
}
