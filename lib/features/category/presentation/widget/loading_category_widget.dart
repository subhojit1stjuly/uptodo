import 'package:flutter/material.dart';

/// A widget to show loading state for categories
class LoadingCategoryWidget extends StatefulWidget {
  /// LoadingCategoryWidget constructor
  const LoadingCategoryWidget({super.key});

  @override
  State<LoadingCategoryWidget> createState() => _LoadingCategoryWidgetState();
}

class _LoadingCategoryWidgetState extends State<LoadingCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
