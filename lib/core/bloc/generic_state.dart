import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_state.freezed.dart';

/// Use GenericState when you need a simpler state representation
/// with predefined states like initial, loading, success, and error.
/// This is useful for straightforward state management without the
/// need for additional fields.
@freezed
class GenericState<T> with _$GenericState<T> {
  /// this is the initial state
  const factory GenericState.initial() = _Initial<T>;

  /// this is the loading state
  const factory GenericState.loading() = _Loading<T>;

  /// this is the success state
  const factory GenericState.success(T data) = _Success<T>;

  /// this is the error state
  const factory GenericState.error(String message) = _Error<T>;
}
