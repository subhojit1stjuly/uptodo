import 'package:flutter/material.dart';

/// this screen is used to show all the permissions and ask user to grant them
class PermissionPage extends StatefulWidget {
  /// since we don't need any data to be passed to this screen
  /// the constructor is empty
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
