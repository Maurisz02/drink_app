import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/test/models/test.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final testProvider = StreamProvider.family.autoDispose<Test, UserId>(
  (
    ref,
    UserId userId,
  ) {
    final controller = StreamController<Test>();

    controller.onListen = () {
      controller.sink.add(
        Test(category: [''], categoryId: userId),
      );
    };

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.bar)
        .where(TestKey.creatorId, isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        final doc = snapshot.docs.first;
        final json = doc.data();

        final test = Test.fromJson(
          json,
          categoryId: doc.id,
        );

        controller.sink.add(test);
      },
    );

    /*final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.bar)
        .doc(userId)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.data() == null) {
          return;
        }
        final test = Test(json: snapshot.data()!);
        print(snapshot.data());
        print(test.category);
        controller.add(test);
      },
    );*/

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
