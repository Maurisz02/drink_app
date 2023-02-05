import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/test/models/test_payload.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class TestUpload {
  const TestUpload();

  Future<bool> saveTestInfo({
    required UserId userId,
    required List<dynamic> categories,
  }) async {
    try {
      final testInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.bar)
          .doc(userId)
          .parent
          .limit(1)
          .get();

      if (testInfo.docs.isNotEmpty) {
        await testInfo.docs.first.reference.update({
          TestKey.category: categories,
        });
        return true;
      }

      final testPayload = TestPayLoad(
        category: categories,
        creatorId: userId,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.bar)
          .doc(userId)
          .set(testPayload);

      return true;
    } catch (e) {
      return false;
    }
  }
}
