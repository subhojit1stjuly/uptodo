import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// This is the state class for the SessionBloc
@freezed
class AuthState with _$AuthState {
  /// this state is emitted when the AuthenticationBloc is created is initial
  const factory AuthState.initial() = AuthStateInitial;
}
