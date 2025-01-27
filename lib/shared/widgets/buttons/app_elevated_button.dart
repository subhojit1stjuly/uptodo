import 'package:flutter/material.dart';

/// This widget is made fot App Text Button for the entire application,
class AppElevatedButton extends StatelessWidget {
  /// the constructor accepts text value and the voidCallBack method
  const AppElevatedButton({
    required this.text,
    required this.onPressed,
    required this.toUpperCase,
    super.key,
  });

  /// button name will be passed here
  final String text;

  /// to make the text upper
  final bool toUpperCase;

  /// onPressed method is passed here
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(toUpperCase ? text.toUpperCase() : text),
    );
  }
}
