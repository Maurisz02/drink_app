import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'dart:collection' show MapView;

import 'package:flutter/rendering.dart';

@immutable
class TestPayLoad extends MapView<String, dynamic> {
  TestPayLoad({
    required List<dynamic> category,
    required UserId creatorId,
  }) : super({
          TestKey.category: category,
          TestKey.creatorId: creatorId,
        });
}
