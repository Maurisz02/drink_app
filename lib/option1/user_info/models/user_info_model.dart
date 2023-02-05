import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/helper/firebase_field_name.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoModel extends MapView<String, dynamic> {
  final UserId userId;
  final String username;
  final String email;

  UserInfoModel({
    required this.userId,
    required this.username,
    required this.email,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.clubUsername: username,
          FirebaseFieldName.clubEmail: email,
          FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
        });

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          username: json[FirebaseFieldName.clubUsername],
          email: json[FirebaseFieldName.clubEmail],
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          username == other.username &&
          email == other.email;

  @override
  int get hashCode => Object.hashAll([
        userId,
        username,
      ]);
}

/* required this.profileFileName,
    required this.profileFileUrl,
    required this.profileThumbnailUrl,
    required this.aspectRatio,*/