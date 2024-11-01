import 'package:flutter/material.dart';

/// This widget is made fot App Text Button for the entire application,
class AppTestButton extends StatelessWidget {
  /// the constructor accepts text value and the voidCallBack method
  const AppTestButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  /// button name will be passed here
  final String text;

  /// onPressed method is passed here
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
