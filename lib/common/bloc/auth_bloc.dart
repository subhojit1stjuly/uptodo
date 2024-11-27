import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/common/bloc/event/auth_event.dart';
import 'package:uptodo/common/bloc/state/auth_state.dart';

///This Authentication bloc, which is handling these flows of the application
/// 1: after Splashscreen checks if user Logged in or not
/// so its calls the AuthSessionCheck event and if session is valid then
/// emits SessionValidState otherwise emits SessionInvalidState
/// if session is invalid then it redirects to onboarding screen
@LazySingleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// this is a bloc constructor
  /// here we are mapping events and states
  AuthBloc() : super(const AuthInitialState()) {
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<SignupSubmittedEvent>(_onSignupSubmitted);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LoginWithFacebookEvent>(_onLoginWithFacebook);
    on<LoginWithAppleEvent>(_onLoginWithApple);
    on<LogoutRequestedEvent>(_onLogoutRequested);
    on<ResetPasswordRequestedEvent>(_onResetPasswordRequested);
    on<SessionCheckEvent>(_onSessionCheck);
    on<SessionExpiredEvent>(_onSessionExpired);
  }

  final _router = GetIt.instance<GoRouter>();

  void _onEmailChanged(EmailChangedEvent event, Emitter<AuthState> emit) {
    // Validate email format
    if (_isValidEmail(event.email)) {
      emit(const FormValidState());
    } else {
      emit(const EmailInvalidState());
    }
  }

  void _onPasswordChanged(
    PasswordChangedEvent event,
    Emitter<AuthState> emit,
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
    Emitter<AuthState> emit,
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
    Emitter<AuthState> emit,
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
    Emitter<AuthState> emit,
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
    Emitter<AuthState> emit,
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
    Emitter<AuthState> emit,
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
    Emitter<AuthState> emit,
  ) async {
    // Logout logic
    emit(const UnauthenticatedState());
    _router.refresh();
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());
    try {
      // Password reset logic
      emit(const PasswordResetSuccessState());
    } catch (e) {
      emit(PasswordResetFailureState(e.toString()));
    }
  }

  Future<void> _onSessionCheck(
    SessionCheckEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Session validation logic
    emit(const SessionValidState());
  }

  Future<void> _onSessionExpired(
    SessionExpiredEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const SessionInvalidState());
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
