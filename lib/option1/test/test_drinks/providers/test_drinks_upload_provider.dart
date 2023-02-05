import 'package:drink_app/option1/test/notifiers/test_upload_notifier.dart';
import 'package:drink_app/option1/test/test_drinks/notifiers/drinks_test_upload_notifier.dart';
import 'package:drink_app/option1/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final drinksTestUploadProvider =
    StateNotifierProvider<DrinksTestUploadNotifier, IsLoading>(
  (ref) => DrinksTestUploadNotifier(),
);
