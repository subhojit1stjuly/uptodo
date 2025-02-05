import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/core/bloc/generic_status.dart';

part 'base_bloc_state.freezed.dart';

/// Use BaseBlocState when you need a more detailed state
/// representation with additional fields like status, data,
/// error, and isLoading. This is useful when you need to manage
/// multiple aspects of the state within a single class.
@freezed
class BaseBlocState<T> with _$BaseBlocState<T> {
  /// this is the base state class for the Blocs
  const factory BaseBlocState({
    required GenericStatus status,
    T? data,
    String? error,
    @Default(false) bool isLoading,
  }) = _BaseBlocState<T>;

  /// this is the initial state
  factory BaseBlocState.initial() => const BaseBlocState(
        status: GenericStatus.initial,
      );

  /// this is the loading state
  factory BaseBlocState.loading() => const BaseBlocState(
        status: GenericStatus.loading,
        isLoading: true,
      );

  /// this is the success state
  factory BaseBlocState.success(T data) => BaseBlocState(
        status: GenericStatus.success,
        data: data,
      );

  /// this is the error state
  factory BaseBlocState.error(String message) => BaseBlocState(
        status: GenericStatus.error,
        error: message,
      );
}
