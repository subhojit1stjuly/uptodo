import 'package:flutter/material.dart';

/// Category item model
class CategoryItem {
  /// Constructor for CategoryItem
  CategoryItem({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  /// Category id
  final int id;

  /// Category name
  final String name;

  /// Category color
  final Color color;

  /// Category icon
  final IconData icon;
}