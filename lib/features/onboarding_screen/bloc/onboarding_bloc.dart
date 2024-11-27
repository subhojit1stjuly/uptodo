import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/assets/assets.gen.dart';
import 'package:uptodo/features/onboarding_screen/bloc/event/onboarding_event.dart';
import 'package:uptodo/features/onboarding_screen/bloc/onboard_model.dart';
import 'package:uptodo/features/onboarding_screen/bloc/state/onboarding_state.dart';
import 'package:uptodo/l10n/app_localizations_service.dart';

/// this the Bloc for the onboarding screen
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  /// this is the constructor for the bloc with initial state sent
  /// to the super class
  OnboardingBloc({required this.localizationsService})
      : super(
          OnboardState(
            data: [
              OnboardModel(
                title: localizationsService.getOnboardingTitle(0),
                desc: localizationsService.getOnboardingDescription(0),
                image: Assets.icons.onboard001.svg(
                  height: 93.5,
                  width: 80.46,
                ),
              ),
              OnboardModel(
                title: localizationsService.getOnboardingTitle(1),
                desc: localizationsService.getOnboardingDescription(1),
                image: Assets.icons.onboard001.svg(
                  height: 93.5,
                  width: 80.46,
                ),
              ),
              OnboardModel(
                title: localizationsService.getOnboardingTitle(2),
                desc: localizationsService.getOnboardingDescription(2),
                image: Assets.icons.onboard001.svg(
                  height: 93.5,
                  width: 80.46,
                ),
              ),
            ],
          ),
        ) {
    on<InitializeEvent>(_initializeOnboarding);
    on<SkippedEvent>(_onSkipped);
    on<BackEvent>(_onBackPress);
    on<NextEvent>(_onNext);
    on<PreviousEvent>(_onPrev);
    on<ChangeEvent>(_onChange);
    on<LoginRedirectEvent>(_loginRedirect);
    on<CreateAccountEvent>(_createAccount);
    final currentState = state;
    _onboardingData = currentState is OnboardState ? currentState.data : [];
  }

  late final List<OnboardModel> _onboardingData;

  /// Localization object
  final AppLocalizationsService localizationsService;

  Future<void> _initializeOnboarding(
    InitializeEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingState.change(0));
  }

  FutureOr<void> _onSkipped(
    SkippedEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const WelComeState());
  }

  FutureOr<void> _onBackPress(
    BackEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      OnboardState(
        data: _onboardingData,
      ),
    );
  }

  FutureOr<void> _onNext(
    NextEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChangeState) {
      emit(
        currentState.pageNo >= 2
            ? const WelComeState()
            : OnboardingState.change(currentState.pageNo + 1),
      );
    }
  }

  FutureOr<void> _onPrev(
    PreviousEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChangeState) {
      emit(
        OnboardingState.change(
          currentState.pageNo > 0 ? currentState.pageNo - 1 : 0,
        ),
      );
    }
  }

  FutureOr<void> _onChange(
    ChangeEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      OnboardingState.change(event.pageNo),
    );
  }

  FutureOr<void> _loginRedirect(
    LoginRedirectEvent event,
    Emitter<OnboardingState> emit,
  ) async {}

  FutureOr<void> _createAccount(
    CreateAccountEvent event,
    Emitter<OnboardingState> emit,
  ) async {}
}
