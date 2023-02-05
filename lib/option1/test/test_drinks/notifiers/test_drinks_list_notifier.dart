import 'package:drink_app/option1/test/test_drinks/models/drinks_test_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TestDrinksListNotifier extends StateNotifier<Iterable<DrinkTestModel>> {
  final Iterable<DrinkTestModel> drinkList;
  TestDrinksListNotifier({required this.drinkList}) : super(drinkList);

  Future<void> listByCategory(String drinkType) async {
    final List<DrinkTestModel> lista = [];
    for (var drink in state) {
      if (drink.drinkType == drinkType) {
        lista.add(drink);
      }
    }
    state = lista;
  }

  void kiir() {
    print('stateben levo piak:');
    for (var drinkName in state) {
      print(drinkName.drinkName);
    }
  }
}
