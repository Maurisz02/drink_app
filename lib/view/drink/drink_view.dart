import 'package:drink_app/option1/auth/providers/user_id_provider.dart';
import 'package:drink_app/option1/test/test_drinks/providers/test_drinks_provider.dart';
import 'package:drink_app/view/drink/drink_detail.dart';
import 'package:drink_app/view/modal_bottom_sheet/modal_sheet_drink.dart';
import 'package:drink_app/view/modal_bottom_sheet/provider/modal_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrinkView extends ConsumerStatefulWidget {
  final String categoryId;
  final String drinkType;
  const DrinkView({
    super.key,
    required this.categoryId,
    required this.drinkType,
  });
  @override
  ConsumerState<DrinkView> createState() => DrinkViewState();
}

class DrinkViewState extends ConsumerState<DrinkView> {
  @override
  Widget build(BuildContext context) {
    final drinks = ref.watch(testDrinksProvider(widget.drinkType));
    final userId = ref.watch(userIdProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drinks'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            drinks.when(
                data: (drinks) {
                  if (drinks.isEmpty) {
                    return const Text('Üres');
                  } else {
                    return DrinkDetail(drinks: drinks);
                  }
                },
                error: ((error, stackTrace) => const Text('Hiba')),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    )),
            ElevatedButton(
              onPressed: () async {
                ref.read(modalChangeProvider.notifier).clearList();
                return const ModalSheetDrinkDialog().present(
                  context,
                  widget.drinkType,
                  userId!,
                );
              },
              child: const Text('Upload drink'),
            )
          ],
        ),
      ),
    );
  }
}
