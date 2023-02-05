import 'package:flutter/foundation.dart' show immutable;

@immutable
class BarKey {
  static const category = 'category';
  static const drinks = 'drinks';
  static const drinkUrl = 'drinkCategoryUrl';
  static const drinkName = 'drinkName';
  static const drinkDetails = 'drinkDetails';
  static const categoryOwner = 'categoryOwner';

  const BarKey._();
}
