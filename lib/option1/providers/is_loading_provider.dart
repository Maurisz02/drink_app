import 'package:drink_app/option1/auth/providers/auth_state_provider.dart';
import 'package:drink_app/option1/test/providers/test_upload_provider.dart';
import 'package:drink_app/option1/test/test_drinks/providers/test_drinks_upload_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);

    final testUpload = ref.watch(testUploadProvider);

    final testDrinksUpload = ref.watch(testUploadProvider); //nem kell

    final drinksTestUpload = ref.watch(drinksTestUploadProvider);

    return authState.isLoading ||
        testUpload ||
        testDrinksUpload ||
        drinksTestUpload;
  },
);
