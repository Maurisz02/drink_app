import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/helper/firebase_field_name.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:drink_app/option1/user_info/models/user_info_payload.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String username,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.clubs)
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.clubUsername: username,
          FirebaseFieldName.clubEmail: email,
        });
        return true;
      }

      final payLoad = UserInfoPayLoad(
        userId: userId,
        username: username,
        email: email,
        createdAt: FieldValue.serverTimestamp(),
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.clubs)
          .add(payLoad);
      return true;
    } catch (e) {
      return false;
    }
  }
}
