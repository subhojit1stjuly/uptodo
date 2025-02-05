import 'package:flutter/material.dart';

/// HomePage is the page where the user will land after login
class HomePage extends StatefulWidget {
  /// const constructor for HomePage
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home'),
    );
  }
}
