import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/auth/providers/user_id_provider.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryIdProvider = FutureProvider<String>(
  (ref) async {
    final userId = ref.watch(userIdProvider);

    final document = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.bar)
        .where(
          TestKey.creatorId,
          isEqualTo: userId,
        )
        .get();

    final categoryId = document.docs.first.id;

    return categoryId;
  },
);
