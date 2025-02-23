import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/constants/locale_constants.dart';
import 'package:uptodo/core/utils/user_preference_utils.dart';
import 'package:uptodo/features/authentication/domain/usecases/session/session_validation_use_case.dart';
import 'package:uptodo/features/authentication/presentation/bloc/event/user_session_event.dart';
import 'package:uptodo/features/authentication/presentation/bloc/state/user_session_state.dart';
import 'package:uptodo/shared/model/user_preference_type.dart';
import 'package:uptodo/shared/usecases/get_preference_by_type_use_case.dart';

///This UserPreferences Bloc, which is handling these flows of the application
/// 1: after Splashscreen checks if user Logged in or not
/// so its calls the AuthSessionCheck event and if session is valid then
/// emits SessionValidState otherwise emits SessionInvalidState
/// if session is invalid then it redirects to onboarding screen
@LazySingleton()
class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  /// this is a bloc constructor
  /// here we are mapping events and states
  UserSessionBloc(
    this._getPrefsByTypeUseCase,
    this._sessionValidationUseCase,
    this._router,
  ) : super(const SessionStateInitial()) {
    on<LoadUserPreferencesEvent>(_onLoadUserPreferences);
    on<SessionCheckEvent>(_onSessionCheck);
    on<SessionExpiredEvent>(_onSessionExpired);
    on<LocalChangesEvent>(_onLocalChanges);
    add(const LoadUserPreferencesEvent());
  }

  final GetPreferenceByTypeUseCase _getPrefsByTypeUseCase;
  final SessionValidationUseCase _sessionValidationUseCase;

  final GoRouter _router;

  FutureOr<void> _onLoadUserPreferences(
    LoadUserPreferencesEvent event,
    Emitter<UserSessionState> emit,
  ) async {
    final language = await _getPrefsByTypeUseCase.execute(
      UserPreferenceType.language,
    );
    final themeMode = await _getPrefsByTypeUseCase.execute(
      UserPreferenceType.themeMode,
    );

    await Future<void>.delayed(const Duration(seconds: 3));
    emit(
      UserSessionState.preferencesChanged(
        preferences: (
          local: UserPreferenceUtils.getPreferenceValue(language),
          themeMode: UserPreferenceUtils.getPreferenceValue(themeMode),
        ),
      ),
    );
    add(const SessionCheckEvent());
  }

  Future<void> _onSessionCheck(
    SessionCheckEvent event,
    Emitter<UserSessionState> emit,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 3));

    /// this is a dummy implementation
    /// in real app we will check if user is logged in or not and then
    /// emit the state accordingly with the help of session validation logic
    /// if session is valid then emit SessionValidState
    /// otherwise emit SessionInvalidState
    /// also will check if the user has seen the onboarding screen or not
    final isSessionValid = await _sessionValidationUseCase.execute(null);
    if (isSessionValid) {
      emit(const UserSessionState.sessionValid());
    } else {
      emit(const UserSessionState.sessionInvalid(hasSeenOnboarding: false));
    }
    _router.refresh();
  }

  Future<void> _onSessionExpired(
    SessionExpiredEvent event,
    Emitter<UserSessionState> emit,
  ) async {
    // when session is expired it is expected that user has seen the onboarding
    emit(const UserSessionState.sessionInvalid(hasSeenOnboarding: true));
    _router.refresh();
  }

  FutureOr<void> _onLocalChanges(
    LocalChangesEvent event,
    Emitter<UserSessionState> emit,
  ) async {
    // TODO(Subhojit): Implement the logic to save the local changes
    emit(
      const UserSessionState.preferencesChanged(
        preferences: (
          local: LocaleConstants.defaultLocale,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
