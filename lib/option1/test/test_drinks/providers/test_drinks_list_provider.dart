import 'package:drink_app/option1/test/providers/category_id_provider.dart';
import 'package:drink_app/option1/test/test_drinks/models/drinks_test_model.dart';
import 'package:drink_app/option1/test/test_drinks/notifiers/test_drinks_list_notifier.dart';
import 'package:drink_app/option1/test/test_drinks/providers/test_drinks_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final testDrinksListProvider =
    StateNotifierProvider<TestDrinksListNotifier, Iterable<DrinkTestModel>>(
  (ref) {
    /*final categoryId = ref.watch(categoryIdProvider);

    final list = [];

    void fillList(
      String categoryId,
      Iterable<DrinkTestModel> drinks,
    ) {}

    categoryId.whenData(
      (categId) {
        final streamDrinkList = ref.watch(
          testDrinksProvider(categId),
        );
        streamDrinkList.whenData((drinkList) {
          return TestDrinksListNotifier(drinkList: drinkList);
        });
      },
    );*/
    return TestDrinksListNotifier(
      drinkList: [],
    );
  },
);
