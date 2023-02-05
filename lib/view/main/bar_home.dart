import 'package:drink_app/option1/auth/providers/auth_state_provider.dart';
import 'package:drink_app/option1/auth/providers/user_id_provider.dart';
import 'package:drink_app/option1/test/providers/test_provider.dart';
import 'package:drink_app/option1/test/providers/test_upload_provider.dart';
import 'package:drink_app/view/drink/drink_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BarHome extends ConsumerStatefulWidget {
  const BarHome({super.key});

  @override
  ConsumerState<BarHome> createState() => _BarHomeState();
}

class _BarHomeState extends ConsumerState<BarHome> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userIdProvider);
    final test = ref.watch(testProvider(userId!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the bar'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authStateProvider.notifier).logOut();
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              child: test.when(
                data: (test) {
                  if (test.category.isEmpty) {
                    return const Text('Üres lista');
                  } else {
                    return Container(
                      width: double.infinity,
                      height: 300,
                      child: ListView.builder(
                        itemCount: test.category.length,
                        itemBuilder: (ctx, i) {
                          final category = test.category.elementAt(i);

                          return ListTile(
                            title: Text(category),
                            onTap: () {
                              if (!mounted) {
                                return;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DrinkView(
                                    categoryId: test.categoryId,
                                    drinkType: category,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                },
                error: (error, stackTrace) {
                  return Text(
                    error.toString(),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final uid = ref.watch(userIdProvider);
                final categ = [
                  'whisky',
                  'champagne',
                  'beer',
                  'vodka',
                ];
                ref
                    .read(testUploadProvider.notifier)
                    .upload(category: categ, userId: uid!);
              },
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
