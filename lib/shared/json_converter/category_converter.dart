import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/core/utils/common_extainsions.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';

/// TimeOfDay JSON converter
class CategoryConverter
    implements JsonConverter<CategoryItem, Map<String, dynamic>> {
  /// Constructor for TimeOfDayConverter
  const CategoryConverter();

  @override
  CategoryItem fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] as int,
      name: json['name'] as String,
      color: Color(int.parse(json['color'] as String)),
      icon: json['icon'].toString().getIconFromCodePoint(),
    );
  }

  @override
  Map<String, dynamic> toJson(CategoryItem object) {
    return {}
      ..['id'] = object.id
      ..['name'] = object.name
      ..['color'] = object.color.toARGB32().toString()
      ..['icon'] = object.icon.codePoint;
  }
}
