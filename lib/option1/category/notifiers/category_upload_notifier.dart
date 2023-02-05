import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/category/models/category_payload.dart';
import 'package:drink_app/option1/helper/bar_key.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/typedefs/is_loading.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryUploadNotifier extends StateNotifier<IsLoading> {
  CategoryUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required List<String> categories,
    required String docId,
    required UserId userId,
  }) async {
    isLoading = true;

    try {
      /*for (var category in categories) {
        final categoryPayload =
            CategoryPayload(category: category, userId: userId);

        final existCategory = await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.bar)
            .doc(userId)
            .get();

        if (existCategory.data()!.containsValue(categories)) {
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.bar)
              .doc(userId)
              .set({BarKey.category: categories});
        } else {
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.bar)
              .doc(userId)
              .update({BarKey.category: categories});
        }

        final allCategory = await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.bar)
            .doc(userId)
            .get();
        for()
      }*/

      //old solution
      for (var category in categories) {
        final categoryPayload = CategoryPayload(
          category: category,
          userId: userId,
        );

//if exsist
        final existCategory = await FirebaseFirestore.instance
            .collection(
              FirebaseCollectionName.clubs,
            )
            .doc(docId)
            .collection(FirebaseCollectionName.bar)
            .where(
              BarKey.category,
              isEqualTo: category,
            )
            .get();

        if (existCategory.docs.isEmpty) {
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.clubs)
              .doc(docId)
              .collection(FirebaseCollectionName.bar)
              .add(categoryPayload);
        }
      }

      final allCategory = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.clubs)
          .doc(docId)
          .collection(FirebaseCollectionName.bar)
          .get();

      for (final delete in allCategory.docs) {
        final doc = delete.data();
        if (!categories.contains(doc[BarKey.category])) {
          await delete.reference.delete();
        }
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
