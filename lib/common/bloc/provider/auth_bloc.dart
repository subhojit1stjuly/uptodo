import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/common/bloc/event/auth_event.dart';
import 'package:uptodo/common/bloc/state/auth_state.dart';

///This Authentication bloc, which is handling these flows of the application
/// 1: after Splashscreen checks if user Logged in or not
/// so its calls the AuthSessionCheck event and if session is valid then
/// emits AuthSessionValidState otherwise emits AuthSessionInvalidState
/// if session is invalid then it redirects to onboarding screen
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// this is a bloc constructor
  /// here we are mapping events and states
  AuthBloc() : super(const AuthInitialState()) {
    on<AuthEmailChangedEvent>(_onEmailChanged);
    on<AuthPasswordChangedEvent>(_onPasswordChanged);
    on<AuthLoginSubmittedEvent>(_onLoginSubmitted);
    on<AuthSignupSubmittedEvent>(_onSignupSubmitted);
    on<AuthLoginWithGoogleEvent>(_onLoginWithGoogle);
    on<AuthLoginWithFacebookEvent>(_onLoginWithFacebook);
    on<AuthLoginWithAppleEvent>(_onLoginWithApple);
    on<AuthLogoutRequestedEvent>(_onLogoutRequested);
    on<AuthResetPasswordRequestedEvent>(_onResetPasswordRequested);
    on<AuthSessionCheckEvent>(_onSessionCheck);
  }

  void _onEmailChanged(AuthEmailChangedEvent event, Emitter<AuthState> emit) {
    // Validate email format
    if (_isValidEmail(event.email)) {
      emit(const AuthFormValidState());
    } else {
      emit(const AuthEmailInvalidState());
    }
  }

  void _onPasswordChanged(
    AuthPasswordChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    // Validate password complexity
    if (_isValidPassword(event.password)) {
      emit(const AuthFormValidState());
    } else {
      emit(const AuthPasswordInvalidState());
    }
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Perform login logic here
      emit(const AuthAuthenticatedState());
    } catch (e) {
      emit(AuthLoginFailureState(e.toString()));
    }
  }

  Future<void> _onSignupSubmitted(
    AuthSignupSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Perform sign-up logic here
      emit(const AuthAuthenticatedState());
    } catch (e) {
      emit(AuthSignupFailureState(e.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(
    AuthLoginWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Google login logic
      emit(const AuthAuthenticatedState());
    } catch (e) {
      emit(AuthLoginFailureState(e.toString()));
    }
  }

  Future<void> _onLoginWithFacebook(
    AuthLoginWithFacebookEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Facebook login logic
      emit(const AuthAuthenticatedState());
    } catch (e) {
      emit(AuthLoginFailureState(e.toString()));
    }
  }

  Future<void> _onLoginWithApple(
    AuthLoginWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Apple login logic
      emit(const AuthAuthenticatedState());
    } catch (e) {
      emit(AuthLoginFailureState(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Logout logic
    emit(const AuthUnauthenticatedState());
  }

  Future<void> _onResetPasswordRequested(
    AuthResetPasswordRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Password reset logic
      emit(const AuthPasswordResetSuccessState());
    } catch (e) {
      emit(AuthPasswordResetFailureState(e.toString()));
    }
  }

  Future<void> _onSessionCheck(
    AuthSessionCheckEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Session validation logic
    emit(const AuthSessionValidState());
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
