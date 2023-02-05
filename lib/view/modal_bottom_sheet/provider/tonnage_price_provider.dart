import 'package:drink_app/view/modal_bottom_sheet/notifier/tonnage_price_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tonnagePriceProvider = ChangeNotifierProvider<TonnagePriceChangeNotifier>(
  (ref) => TonnagePriceChangeNotifier(),
);
