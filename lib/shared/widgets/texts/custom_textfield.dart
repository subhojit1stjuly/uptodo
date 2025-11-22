import 'package:flutter/material.dart';

/// Custom styled TextFormField with password visibility toggle support
class CustomTextField extends StatefulWidget {
  /// Constructor for the CustomTextField
  const CustomTextField({
    this.labelText = '',
    this.hintText,
    super.key,
    this.controller,
    this.validator,
    this.keyboardType,
    this.decoration,
    this.isPassword = false,
    this.errorText,
    this.autoValidateMode,
  });

  /// Label text displayed above the TextFormField
  final String labelText;

  /// Hint text displayed inside the TextFormField
  final String? hintText;

  /// Controller for managing the text being edited.
  final TextEditingController? controller;

  /// Function for validating the input text.
  final String? Function(String?)? validator;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// Custom decoration for the TextFormField.
  final InputDecoration? decoration;

  /// Whether the field should obscure the text (for passwords).
  final bool isPassword;

  /// Error text to display below the TextFormField.
  final String? errorText;

  /// Controls the auto-validation behavior of the TextFormField.
  final AutovalidateMode? autoValidateMode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// ValueNotifier to manage password visibility state
  late final ValueNotifier<bool> _obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize the ValueNotifier with true (password hidden by default)
    _obscureTextNotifier = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    // Dispose the ValueNotifier to prevent memory leaks
    _obscureTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = Theme.of(context).inputDecorationTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label text positioned above the TextFormField
        if (widget.labelText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              widget.labelText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        // Custom styled TextFormField with ValueListenableBuilder for password visibility
        ValueListenableBuilder<bool>(
          valueListenable: _obscureTextNotifier,
          builder: (context, obscureText, child) {
            return TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              autovalidateMode: widget.autoValidateMode,
              keyboardType: widget.isPassword
                  ? TextInputType.visiblePassword
                  : widget.keyboardType,
              obscureText: widget.isPassword && obscureText,
              decoration:
                  (widget.decoration ?? const InputDecoration()).copyWith(
                hintText: widget.hintText,
                errorText: widget.errorText,
                // BLoC error takes precedence
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                // Merge with theme's input decoration
                isDense:
                    widget.decoration?.isDense ?? defaultDecoration.isDense,
                contentPadding: widget.decoration?.contentPadding ??
                    defaultDecoration.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                // Border styling
                border: widget.decoration?.border ??
                    defaultDecoration.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                enabledBorder: widget.decoration?.enabledBorder ??
                    defaultDecoration.enabledBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: widget.errorText != null
                            ? Theme.of(context).colorScheme.error
                            : Colors.grey.shade400,
                      ),
                    ),
                focusedBorder: widget.decoration?.focusedBorder ??
                    defaultDecoration.focusedBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: widget.errorText != null
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                errorBorder: widget.decoration?.errorBorder ??
                    defaultDecoration.errorBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                // Remove the default floating label behavior
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // Password visibility toggle icon button
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // Toggle password visibility
                          _obscureTextNotifier.value =
                              !_obscureTextNotifier.value;
                        },
                      )
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }
}
