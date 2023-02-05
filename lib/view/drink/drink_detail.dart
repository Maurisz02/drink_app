import 'package:drink_app/option1/auth/providers/user_id_provider.dart';
import 'package:drink_app/option1/test/test_drinks/models/drinks_test_model.dart';
import 'package:drink_app/option1/test/test_drinks/providers/test_drinks_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrinkDetail extends ConsumerWidget {
  final Iterable<DrinkTestModel> drinks;
  const DrinkDetail({
    super.key,
    required this.drinks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 300,
        child: ListView.builder(
          itemCount: drinks.length,
          itemBuilder: (ctx, i) {
            final drink = drinks.elementAt(i);

            return ListTile(
              title: Text(drink.drinkName),
              trailing: IconButton(
                color: const Color.fromARGB(255, 237, 50, 55),
                onPressed: () {
                  final userId = ref.watch(userIdProvider);
                  ref.read(drinksTestUploadProvider.notifier).deleteDrink(
                        userId: userId!,
                        drinkName: drink.drinkName,
                      );
                },
                icon: const Icon(
                  Icons.delete_rounded,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
