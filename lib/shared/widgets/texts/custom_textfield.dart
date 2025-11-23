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
    this.autoValidationRequired = false,
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
  final bool autoValidationRequired;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// Manages password visibility state (password hidden by default)
  bool _obscureText = true;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

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
        // Custom styled TextFormField
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            final error = widget.validator?.call(value);

            // Switch to auto-validation after first error
            if (error != null &&
                _autoValidateMode == AutovalidateMode.disabled) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _autoValidateMode = AutovalidateMode.onUserInteraction;
                  });
                }
              });
            }

            return error;
          },
          autovalidateMode: widget.autoValidationRequired
              ? _autoValidateMode
              : AutovalidateMode.disabled,
          keyboardType: widget.isPassword
              ? TextInputType.visiblePassword
              : widget.keyboardType,
          obscureText: widget.isPassword && _obscureText,
          decoration: (widget.decoration ?? const InputDecoration()).copyWith(
            hintText: widget.hintText,
            errorText: widget.errorText,
            // BLoC error takes precedence
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            // Merge with theme's input decoration
            isDense: widget.decoration?.isDense ?? defaultDecoration.isDense,
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
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // Toggle password visibility
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
