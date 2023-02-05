import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/auth/providers/user_id_provider.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/test/test_drinks/models/drinks_test_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final testDrinksProvider =
    StreamProvider.family.autoDispose<Iterable<DrinkTestModel>, String>(
  (
    ref,
    String drinkType,
  ) {
    final controller = StreamController<Iterable<DrinkTestModel>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final userId = ref.watch(userIdProvider);

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.bar)
        .doc(userId)
        .collection(FirebaseCollectionName.drinks)
        .where(TestKey.drinkType, isEqualTo: drinkType)
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;

        final drinks = documents.map(
          (doc) => DrinkTestModel(
            json: doc.data(),
          ),
        );

        for (var drink in drinks) {
          print(drink.drinkName);
        }

        controller.add(drinks);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
