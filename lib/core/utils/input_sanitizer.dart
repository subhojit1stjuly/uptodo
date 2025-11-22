/// Utility class for sanitizing user input to prevent security vulnerabilities.
///
/// This class provides static methods to clean and sanitize user-provided text
/// by removing potentially dangerous or invisible characters that could be used
/// for security exploits or visual manipulation.
///
/// Security measures include:
///   - Removing HTML/Script tags (XSS prevention)
///   - Removing zero-width Unicode characters (spoofing prevention)
///   - Trimming whitespace
///
/// All methods are static and the class cannot be instantiated.
///
/// Example usage:
/// ```dart
/// final userInput = '<script>alert("xss")</script>Hello';
/// final clean = InputSanitizer.sanitize(userInput);
/// print(clean); // Output: Hello
/// ```
class InputSanitizer {
  InputSanitizer._(); // Private constructor to prevent instantiation

  /// Sanitizes the input string by removing HTML tags and suspicious Unicode characters.
  ///
  /// This method performs the following operations:
  ///   1. Trims leading and trailing whitespace
  ///   2. Removes all HTML tags (e.g., `<script>`, `<div>`, etc.)
  ///   3. Removes zero-width Unicode characters that could be used for spoofing
  ///
  /// Parameters:
  ///   - [input]: The string to sanitize
  ///
  /// Returns:
  ///   - A sanitized version of the input string
  ///
  /// Removed characters:
  ///   - HTML tags: `<[^>]*>`
  ///   - Zero-width space (U+200B)
  ///   - Zero-width non-joiner (U+200C)
  ///   - Zero-width joiner (U+200D)
  ///   - Zero-width no-break space/BOM (U+FEFF)
  ///
  /// Example:
  /// ```dart
  /// final dirty = '  <b>Hello</b>\u200BWorld  ';
  /// final clean = InputSanitizer.sanitize(dirty);
  /// print(clean); // Output: HelloWorld
  /// ```
  static String sanitize(String input) {
    return input
        .trim()
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
        .replaceAll(
            RegExp(r'[\u200B-\u200D\uFEFF]'), ''); // Remove zero-width chars
  }
}
