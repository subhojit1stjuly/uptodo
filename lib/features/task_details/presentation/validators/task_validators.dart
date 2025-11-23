/// Utility class containing validation methods for task-related inputs.
///
/// This class provides static methods to validate task titles and descriptions,
/// ensuring data integrity and security by preventing:
///   - Empty or invalid input
///   - XSS (Cross-Site Scripting) attacks
///   - Unicode-based exploits
///   - DoS (Denial of Service) through excessive input length
///
/// All methods are static and the class cannot be instantiated.
///
/// Example usage:
/// ```dart
/// final titleError = TaskValidators.validateTitle(titleController.text);
/// if (titleError != null) {
///   // Show error to user
///   print(titleError);
/// }
/// ```
class TaskValidators {
  TaskValidators._(); // Private constructor to prevent instantiation

  /// Validates the task title input.
  ///
  /// Checks if the provided [value] meets the requirements for a valid task title.
  ///
  /// Parameters:
  ///   - [value]: The title string to validate, can be null
  ///
  /// Returns:
  ///   - `null` if the validation passes
  ///   - A `String` error message if the validation fails
  ///
  /// Common validation rules may include:
  ///   - Checking if the value is not null or empty
  ///   - Ensuring minimum/maximum length requirements
  ///   - Verifying character constraints
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }

    // 🔒 Security: Prevent XSS or injection attacks
    if (_containsHtmlTags(value)) {
      return 'Title contains invalid characters';
    }

    // 🔒 Security: Sanitize special characters if needed
    final sanitized = value.trim();

    if (sanitized.length < 3) {
      return 'Title must be at least 3 characters';
    }
    if (sanitized.length > 100) {
      return 'Title must be less than 100 characters';
    }

    // 🔒 Security: Prevent Unicode exploits
    if (_containsSuspiciousUnicode(sanitized)) {
      return 'Title contains invalid characters';
    }

    return null;
  }

  /// Validates the task description input.
  ///
  /// Checks if the provided [value] meets the requirements for a valid task description.
  ///
  /// Parameters:
  ///   - [value]: The description string to validate, can be null
  ///
  /// Returns:
  ///   - `null` if the validation passes
  ///   - A `String` error message if the validation fails
  ///
  /// Validation rules:
  ///   - Must not be null or empty
  ///   - Maximum length of 5000 characters (DoS prevention)
  ///   - Must not contain HTML tags
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }

    // 🔒 Security: Length limits to prevent DoS
    if (value.length > 5000) {
      return 'Description is too long';
    }

    if (_containsHtmlTags(value)) {
      return 'Description contains invalid characters';
    }

    return null;
  }

  /// Helper method to detect HTML or script tags in the input.
  ///
  /// This method prevents XSS (Cross-Site Scripting) attacks by identifying
  /// HTML tags in user input.
  ///
  /// Parameters:
  ///   - [value]: The string to check for HTML tags
  ///
  /// Returns:
  ///   - `true` if HTML tags are found
  ///   - `false` otherwise
  ///
  /// Example:
  /// ```dart
  /// _containsHtmlTags('<script>alert("test")</script>'); // returns true
  /// _containsHtmlTags('Normal text'); // returns false
  /// ```
  static bool _containsHtmlTags(String value) {
    final htmlPattern = RegExp(r'<[^>]*>', caseSensitive: false);
    return htmlPattern.hasMatch(value);
  }

  /// Helper method to detect suspicious Unicode characters.
  ///
  /// This method prevents Unicode-based exploits by identifying potentially
  /// malicious Unicode characters such as:
  ///   - Zero-width characters (U+200B-U+200D)
  ///   - Zero-width no-break space (U+FEFF)
  ///   - RTL (Right-to-Left) override characters (U+202A-U+202E)
  ///
  /// These characters can be used for:
  ///   - Text spoofing
  ///   - Visual manipulation
  ///   - Security exploits
  ///
  /// Parameters:
  ///   - [value]: The string to check for suspicious Unicode characters
  ///
  /// Returns:
  ///   - `true` if suspicious Unicode characters are found
  ///   - `false` otherwise
  ///
  /// Example:
  /// ```dart
  /// _containsSuspiciousUnicode('Normal text'); // returns false
  /// _containsSuspiciousUnicode('Text\u200Bwith\u200Dzero-width'); // returns true
  /// ```
  static bool _containsSuspiciousUnicode(String value) {
    // Detect zero-width characters, RTL overrides, etc.
    final suspiciousPattern = RegExp(
      r'[\u200B-\u200D\uFEFF\u202A-\u202E]',
    );
    return suspiciousPattern.hasMatch(value);
  }
}
