import 'package:flutter/material.dart';

/// Custom styled TextFormField
class CustomTextField extends StatefulWidget {
  /// Constructor for the CustomTextField
  const CustomTextField({
    required this.labelText,
    this.hintText,
    super.key,
    this.controller,
    this.validator,
    this.keyboardType,
    this.decoration,
    this.isPassword = false,
  });

  /// The label text for the TextFormField
  final String labelText;

  /// The hint text for the TextFormField
  final String? hintText;

  /// The controller for the TextFormField
  final TextEditingController? controller;

  /// The validator function for the TextFormField
  final String? Function(String?)? validator;

  /// The keyboard type for the TextFormField
  final TextInputType? keyboardType;

  /// The decoration for the TextFormField
  final InputDecoration? decoration;

  /// Whether the TextFormField is a password field
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Get the default input decoration from the theme
    final defaultDecoration = Theme.of(context).inputDecorationTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label text positioned above the TextFormField
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
          validator: widget.validator,
          keyboardType: widget.isPassword
              ? TextInputType.visiblePassword
              : widget.keyboardType,
          obscureText: widget.isPassword && _obscureText,
          decoration: (widget.decoration ?? const InputDecoration()).copyWith(
            hintText: widget.hintText,
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
                    color: Colors.grey.shade400,
                  ),
                ),
            focusedBorder: widget.decoration?.focusedBorder ??
                defaultDecoration.focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
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
          ),
        ),
      ],
    );
  }
}
