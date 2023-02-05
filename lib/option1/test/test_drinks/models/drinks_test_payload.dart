import 'dart:collection' show MapView;

import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class DrinksTestPayload extends MapView<String, dynamic> {
  DrinksTestPayload({
    required String drinkName,
    required String drinkTonnage,
    required String drinkCurrency,
    required String drinkType,
    required Map<String, String> drinkPriceList,
  }) : super({
          TestKey.drinkName: drinkName,
          TestKey.drinkTonnage: drinkTonnage,
          TestKey.drinkCurrency: drinkCurrency,
          TestKey.drinkType: drinkType,
          TestKey.drinkPriceList: drinkPriceList,
        });
}
