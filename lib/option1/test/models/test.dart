import 'dart:collection' show MapView;

import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Test extends MapView<String, dynamic> {
  final List<dynamic> category;
  final String categoryId;

  Test({
    required this.category,
    required this.categoryId,
  }) : super({
          TestKey.categoryId: categoryId,
          TestKey.category: category,
        });

  Test.fromJson(
    Map<String, dynamic> json, {
    required String categoryId,
  }) : this(
          categoryId: categoryId,
          category: json[TestKey.category],
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Test &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          categoryId == other.categoryId;

  @override
  int get hashCode => Object.hashAll([
        category,
        categoryId,
      ]);
}
