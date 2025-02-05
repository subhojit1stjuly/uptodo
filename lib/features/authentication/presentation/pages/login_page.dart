import 'package:flutter/material.dart';

/// LoginPage is the page where the user will login
class LoginPage extends StatefulWidget {
  /// const constructor for LoginPage
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('LoginPage'),
    );
  }
}
