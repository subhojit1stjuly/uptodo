import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/domain/usecases/login/login_with_email.dart';
import 'package:uptodo/features/authentication/domain/usecases/login/login_with_google_use_case.dart';
import 'package:uptodo/features/authentication/domain/usecases/login/login_with_phone.dart';
import 'package:uptodo/features/authentication/domain/usecases/signup/register_with_email.dart';
import 'package:uptodo/features/authentication/domain/usecases/signup/register_with_google_use_case.dart';
import 'package:uptodo/features/authentication/domain/usecases/signup/register_with_phone.dart';
import 'package:uptodo/features/authentication/presentation/bloc/event/auth_event.dart';
import 'package:uptodo/features/authentication/presentation/bloc/state/auth_state.dart';

@LazySingleton()
class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final LogInWithEmailUseCase _logInWithEmailUseCase;
  final LoginWithGoogleUseCase _logInWithGoogleUseCase;
  final LoginWithPhone _logInWithPhoneUseCase;

  final RegisterWithEmailUseCase _registerWithEmailUseCase;
  final RegisterWithGoogleUseCase _registerWithGoogleUseCase;
  final RegisterWithPhone _registerWithPhoneUseCase;

  AuthenticationBloc(
    this._logInWithEmailUseCase,
    this._logInWithGoogleUseCase,
    this._logInWithPhoneUseCase,
    this._registerWithEmailUseCase,
    this._registerWithGoogleUseCase,
    this._registerWithPhoneUseCase,
  ) : super(AuthState.initial()) {
    /// Login Events
    on<LoginWithGoogleEvent>(_loginWithGoogle);
    on<LoginWithPhoneEvent>(_loginWithPhone);
    on<LoginWithEmailEvent>(_loginWithEmail);

    /// Sign in events
    on<RegisterWithGoogleEvent>(_registerWithGoogle);
    on<RegisterWithPhoneEvent>(_registerWithPhone);
    on<RegisterWithEmailEvent>(_registerWithEmail);
  }

  Future<void> _loginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _logInWithGoogleUseCase.execute(null);
  }

  Future<void> _loginWithPhone(
    LoginWithPhoneEvent event,
    Emitter<AuthState> emit,
  ) async {}

  Future<void> _loginWithEmail(
    LoginWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {}

  Future<void> _registerWithGoogle(
    RegisterWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {}

  Future<void> _registerWithPhone(
    RegisterWithPhoneEvent event,
    Emitter<AuthState> emit,
  ) async {}

  Future<void> _registerWithEmail(
    RegisterWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {}
}
