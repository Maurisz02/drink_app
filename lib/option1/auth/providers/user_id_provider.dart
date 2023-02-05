import 'package:drink_app/option1/auth/providers/auth_state_provider.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider<UserId?>(
  (ref) => ref.watch(authStateProvider).userId,
);
