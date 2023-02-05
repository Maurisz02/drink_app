import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/category/models/category.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../typedefs/user_id.dart';

final categoriesProvider =
    StreamProvider.family.autoDispose<Iterable<Category>, UserId>(
  (ref, UserId docId) {
    final controller = StreamController<Iterable<Category>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.clubs)
        .doc(docId)
        .collection(FirebaseCollectionName.bar)
        .snapshots()
        .listen(
      (snapshot) {
        final categories = snapshot.docs.map(
          (doc) => Category(
            categoryDocId: doc.id,
            json: doc.data(),
          ),
        );

        controller.sink.add(categories);
      },
    );

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });

    return controller.stream;
  },
);
