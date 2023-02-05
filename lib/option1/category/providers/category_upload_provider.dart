import 'package:drink_app/option1/category/notifiers/category_upload_notifier.dart';
import 'package:drink_app/option1/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryUploadProvider =
    StateNotifierProvider<CategoryUploadNotifier, IsLoading>(
  (ref) => CategoryUploadNotifier(),
);
