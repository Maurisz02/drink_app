import 'dart:collection' show MapView;

import 'package:drink_app/option1/helper/firebase_field_name.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoPayLoad extends MapView<String, dynamic> {
  UserInfoPayLoad({
    required userId,
    required username,
    required email,
    required createdAt,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.clubUsername: username,
          FirebaseFieldName.clubEmail: email,
          FirebaseFieldName.createdAt: createdAt,
        });
}
