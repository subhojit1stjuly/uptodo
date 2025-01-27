import 'package:flutter/material.dart';

/// This widget is made fot App Text Button for the entire application,
class AppOutlineButton extends StatelessWidget {
  /// the constructor accepts text value and the voidCallBack method
  const AppOutlineButton({
    required this.text,
    required this.toUpperCase,
    required this.onPressed,
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
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        toUpperCase ? text.toUpperCase() : text,
      ),
    );
  }
}
