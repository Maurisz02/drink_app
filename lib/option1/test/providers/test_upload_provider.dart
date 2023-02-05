import 'package:drink_app/option1/test/notifiers/test_upload_notifier.dart';
import 'package:drink_app/option1/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final testUploadProvider = StateNotifierProvider<TestUploadNotifier, IsLoading>(
  (ref) => TestUploadNotifier(),
);
