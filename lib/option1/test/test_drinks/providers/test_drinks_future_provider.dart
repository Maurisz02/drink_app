import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/test/helper/categ_id_type.dart';
import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/test/test_drinks/models/drinks_test_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final testDrinksFutureProvider = FutureProvider.family
    .autoDispose<Iterable<DrinkTestModel>, CategIdDrinkType>(
  (
    ref,
    CategIdDrinkType data,
  ) async {
    final documents = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.bar)
        .doc(data.categoryId)
        .collection(FirebaseCollectionName.drinks)
        .where(TestKey.drinkType, isEqualTo: data.drinkType)
        .get();

    final drinks = documents.docs.map(
      (doc) => DrinkTestModel(
        json: doc.data(),
      ),
    );

    print(documents.docs.first.data());

    /*var drinks;

    for (var document in documents.docs) {
      if (document.data().containsKey(data.drinkType)) {
        drinks = DrinkTestModel(
          json: document.data(),
        );
      }
    }*/

    /*final drinks = documents.docs.map((e) {
      if (e.data().containsValue(data.drinkType)) {
        return DrinkTestModel(json: e.data());
      } else {
        return DrinkTestModel(
          json: e.data(),
        );
      }
    });

    if (drinks.isEmpty) {
      return [];
    }*/

    return drinks;
  },
);
