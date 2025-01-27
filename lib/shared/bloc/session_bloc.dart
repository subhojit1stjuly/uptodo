import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/shared/bloc/event/session_event.dart';
import 'package:uptodo/shared/bloc/state/session_state.dart';

///This Authentication bloc, which is handling these flows of the application
/// 1: after Splashscreen checks if user Logged in or not
/// so its calls the AuthSessionCheck event and if session is valid then
/// emits SessionValidState otherwise emits SessionInvalidState
/// if session is invalid then it redirects to onboarding screen
@LazySingleton()
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  /// this is a bloc constructor
  /// here we are mapping events and states
  SessionBloc() : super(const SessionInitialState()) {
    /*on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<SignupSubmittedEvent>(_onSignupSubmitted);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LoginWithFacebookEvent>(_onLoginWithFacebook);
    on<LoginWithAppleEvent>(_onLoginWithApple);
    on<LogoutRequestedEvent>(_onLogoutRequested);
    on<ResetPasswordRequestedEvent>(_onResetPasswordRequested);*/
    on<SessionCheckEvent>(_onSessionCheck);
    on<SessionExpiredEvent>(_onSessionExpired);
    add(const SessionCheckEvent());
  }

  final _router = GetIt.instance<GoRouter>();

  /*void _onEmailChanged(EmailChangedEvent event, Emitter<SessionState> emit) {
    // Validate email format
    if (_isValidEmail(event.email)) {
      emit(const FormValidState());
    } else {
      emit(const EmailInvalidState());
    }
  }

  void _onPasswordChanged(
    PasswordChangedEvent event,
    Emitter<SessionState> emit,
  ) {
    // Validate password complexity
    if (_isValidPassword(event.password)) {
      emit(const FormValidState());
    } else {
      emit(const PasswordInvalidState());
    }
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Perform login logic here
      emit(const AuthenticatedState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  Future<void> _onSignupSubmitted(
    SignupSubmittedEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Perform sign-up logic here
      emit(const AuthenticatedState());
    } catch (e) {
      emit(SignupFailureState(e.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Google login logic
      emit(const AuthenticatedState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  Future<void> _onLoginWithFacebook(
    LoginWithFacebookEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Facebook login logic
      emit(const AuthenticatedState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithAppleEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Apple login logic
      emit(const AuthenticatedState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequestedEvent event,
    Emitter<SessionState> emit,
  ) async {
    // Logout logic
    emit(const UnauthenticatedState());
    _router.refresh();
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequestedEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Password reset logic
      emit(const PasswordResetSuccessState());
    } catch (e) {
      emit(PasswordResetFailureState(e.toString()));
    }
  }*/

  Future<void> _onSessionCheck(
    SessionCheckEvent event,
    Emitter<SessionState> emit,
  ) async {
    // Session validation logic
    emit(const SessionState.sessionValid());
    _router.refresh();
  }

  Future<void> _onSessionExpired(
    SessionExpiredEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const SessionState.sessionInvalid());
    _router.refresh();
  }

  bool _isValidEmail(String email) {
    // Email validation logic here
    return email.contains('@');
  }

  bool _isValidPassword(String password) {
    // Password validation logic here
    return password.length >= 6;
  }
}
