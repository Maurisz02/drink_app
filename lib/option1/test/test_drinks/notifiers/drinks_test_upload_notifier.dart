import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_app/option1/helper/bar_key.dart';
import 'package:drink_app/option1/helper/firebase_collection_name.dart';
import 'package:drink_app/option1/test/helper/test_key.dart';
import 'package:drink_app/option1/test/test_drinks/models/drinks_test_payload.dart';
import 'package:drink_app/option1/typedefs/is_loading.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrinksTestUploadNotifier extends StateNotifier<IsLoading> {
  DrinksTestUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required UserId userId,
    required String drinkName,
    required String drinkTonnage,
    required String drinkCurrency,
    required String drinkType,
    required Map<String, String> drinkPriceList,
  }) async {
    isLoading = true;

    try {
      final drinkTestPayload = DrinksTestPayload(
        drinkName: drinkName,
        drinkTonnage: drinkTonnage,
        drinkCurrency: drinkCurrency,
        drinkType: drinkType,
        drinkPriceList: drinkPriceList,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.bar)
          .doc(userId)
          .collection(FirebaseCollectionName.drinks)
          .add(drinkTestPayload);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<bool> deleteDrink({
    required UserId userId,
    required String drinkName,
  }) async {
    isLoading = true;

    try {
      final delete = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.bar)
          .doc(userId)
          .collection(FirebaseCollectionName.drinks)
          .where(TestKey.drinkName, isEqualTo: drinkName)
          .get();

      delete.docs.first.reference.delete();

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
