import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/test/backend/test_upload.dart';
import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/test/models/test_payload.dart';
import 'package:drink_app/option1/typedefs/is_loading.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TestUploadNotifier extends StateNotifier<IsLoading> {
  final _testInfoStorage = const TestUpload();

  TestUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required List<dynamic> category,
    required UserId userId,
  }) async {
    isLoading = true;

    try {
      await _testInfoStorage.saveTestInfo(
        userId: userId,
        categories: category,
      );
      /*final testPayload = TestPayLoad(
        category: category,
        creatorId: userId,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.bar)
          .doc(userId)
          .set(testPayload);*/

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
