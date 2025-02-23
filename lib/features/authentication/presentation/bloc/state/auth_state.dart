import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// This is the state class for the SessionBloc
@freezed
class AuthState with _$AuthState {
  /// this state is emitted when the AuthenticationBloc is created is initial
  const factory AuthState.initial() = AuthStateInitial;

  /// this state is emitted when the login is successful
  const factory AuthState.loginSuccess() = AuthStateLoginSuccess;

  /// this state is emitted when the register is successful

  const factory AuthState.registerSuccess() = AuthStateRegisterSuccess;

  /// this state is emitted when the login is unsuccessful
  const factory AuthState.loginFailed() = AuthStateLoginFailed;

  /// this state is emitted when the register is unsuccessful
  const factory AuthState.registerFailed() = AuthStateRegisterFailed;
}
