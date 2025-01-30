/// Generic state for all blocs
enum GenericStatus {
  /// this state is emitted when the session is initial
  initial,

  /// this state is emitted when the session is loading
  loading,

  /// this state is emitted when the session is valid
  success,

  /// this state is emitted when the session is invalid
  error
}
