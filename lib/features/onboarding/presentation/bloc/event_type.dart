/// Enum for the different types of events that
/// can be triggered in the onboarding bloc
enum TaskPropertyEvents {
  /// datePicker event
  datePicker,

  /// Event to open a picker with specified type
  timePicker,

  /// Event to set a task category
  categoryPicker,

  /// Event to set a task priority
  priorityPicker,
}
