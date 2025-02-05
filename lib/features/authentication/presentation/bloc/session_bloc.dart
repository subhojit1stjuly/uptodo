import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/presentation/bloc/event/session_event.dart';
import 'package:uptodo/features/authentication/presentation/bloc/state/session_state.dart';

///This Authentication bloc, which is handling these flows of the application
/// 1: after Splashscreen checks if user Logged in or not
/// so its calls the AuthSessionCheck event and if session is valid then
/// emits SessionValidState otherwise emits SessionInvalidState
/// if session is invalid then it redirects to onboarding screen
@LazySingleton()
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  /// this is a bloc constructor
  /// here we are mapping events and states
  SessionBloc() : super(const SessionStateInitial()) {
    on<SessionCheckEvent>(_onSessionCheck);
    on<SessionExpiredEvent>(_onSessionExpired);
    add(const SessionCheckEvent());
  }

  final _router = GetIt.instance<GoRouter>();

  Future<void> _onSessionCheck(
    SessionCheckEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const SessionState.loading());
    // Session validation logic
    await Future<void>.delayed(const Duration(seconds: 3));

    /// this is a dummy implementation
    /// in real app we will check if user is logged in or not and then
    /// emit the state accordingly with the help of session validation logic
    /// if session is valid then emit SessionValidState
    /// otherwise emit SessionInvalidState
    /// also will check if the user has seen the onboarding screen or not
    emit(const SessionState.sessionInvalid(hasSeenOnboarding: false));
    // emit(const SessionState.sessionValid());
    _router.refresh();
  }

  Future<void> _onSessionExpired(
    SessionExpiredEvent event,
    Emitter<SessionState> emit,
  ) async {
    // when session is expired it is expected that user has seen the onboarding
    emit(const SessionState.sessionInvalid(hasSeenOnboarding: true));
    _router.refresh();
  }
}
