import 'dart:collection' show MapView;

import 'package:drink_app/option1/helper/bar_key.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class CategoryPayload extends MapView<String, dynamic> {
  CategoryPayload({
    required String category,
    required UserId userId,
  }) : super({
          BarKey.category: category,
          BarKey.categoryOwner: userId,
        });
}
