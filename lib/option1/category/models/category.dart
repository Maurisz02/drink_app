import 'package:drink_app/option1/helper/bar_key.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Category {
  final String category;
  final String categoryDocId;

  Category({
    required Map<String, dynamic> json,
    required this.categoryDocId,
  }) : category = json[BarKey.category];
}
