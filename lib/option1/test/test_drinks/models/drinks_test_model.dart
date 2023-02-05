import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class DrinkTestModel {
  final String drinkName;
  final String drinkTonnage;
  final String drinkCurrency;
  final String drinkType;
  final Map<String, dynamic> drinkPriceList;

  DrinkTestModel({
    required Map<String, dynamic> json,
  })  : drinkName = json[TestKey.drinkName],
        drinkTonnage = json[TestKey.drinkTonnage],
        drinkCurrency = json[TestKey.drinkCurrency],
        drinkType = json[TestKey.drinkType],
        drinkPriceList = json[TestKey.drinkPriceList];
}
