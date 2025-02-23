import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/domain/usecases/auth/login_with_email.dart';
import 'package:uptodo/features/authentication/domain/usecases/auth/login_with_google_use_case.dart';
import 'package:uptodo/features/authentication/domain/usecases/auth/login_with_phone.dart';
import 'package:uptodo/features/authentication/domain/usecases/auth/register_with_email.dart';
import 'package:uptodo/features/authentication/presentation/bloc/event/auth_event.dart';
import 'package:uptodo/features/authentication/presentation/bloc/state/auth_state.dart';

/// Bloc for handling authentication events and states
@injectable
class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructor for the AuthenticationBloc
  AuthenticationBloc(
    this._logInWithEmailUseCase,
    this._logInWithGoogleUseCase,
    this._logInWithPhoneUseCase,
    this._registerWithEmailUseCase,) : super(const AuthState.initial()) {
    /// Login Events
    on<LoginWithGoogleEvent>(_loginWithGoogle);
    on<LoginWithPhoneEvent>(_loginWithPhone);
    on<LoginWithEmailEvent>(_loginWithEmail);

    /// Sign in events
    on<RegisterWithEmailEvent>(_registerWithEmail);
  }

  final LogInWithEmailUseCase _logInWithEmailUseCase;
  final LoginWithGoogleUseCase _logInWithGoogleUseCase;
  final LoginWithPhone _logInWithPhoneUseCase;

  final RegisterWithEmailUseCase _registerWithEmailUseCase;

  Future<void> _loginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _logInWithGoogleUseCase.execute(null);
  }

  Future<void> _loginWithPhone(
    LoginWithPhoneEvent event,
    Emitter<AuthState> emit,) async {
    await _logInWithPhoneUseCase.execute(null);
  }

  Future<void> _loginWithEmail(
    LoginWithEmailEvent event,
    Emitter<AuthState> emit,) async {
    await _logInWithEmailUseCase.execute(
      (email: event.email, password: event.password),
    );
  }

  Future<void> _registerWithEmail(
    RegisterWithEmailEvent event,
    Emitter<AuthState> emit,) async {
    await _registerWithEmailUseCase.execute(
      (email: event.email, password: event.password),
    );
  }
}
