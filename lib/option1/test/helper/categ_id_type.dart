import 'package:flutter/foundation.dart' show immutable;

@immutable
class CategIdDrinkType {
  final String categoryId;
  final String drinkType;

  const CategIdDrinkType({
    required this.categoryId,
    required this.drinkType,
  });
}
