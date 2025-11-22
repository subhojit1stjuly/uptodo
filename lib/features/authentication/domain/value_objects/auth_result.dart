import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/authentication/data/models/user_info_model.dart';

part 'auth_result.freezed.dart';

/// AuthResult is a class that will be used to
/// represent the result of an authentication operation.
@freezed
abstract class AuthResult with _$AuthResult {
  /// constructor for the AuthResult
  /// with the given fields replaced by the non-null parameter values.
  const factory AuthResult({
    required bool success,
    UserInfoModel? user,
    String? error,
  }) = _AuthResult;

  /// This method represents the success of an authentication operation.
  factory AuthResult.success({UserInfoModel? user}) => AuthResult(
        success: true,
        user: user,
      );

  /// This method represents the failure of an authentication operation.
  factory AuthResult.failure({required String message}) => AuthResult(
        success: false,
        error: message,
      );
}
