import 'package:drink_app/option1/auth/backend/authenticator.dart';
import 'package:drink_app/option1/auth/models/auth_state.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:drink_app/option1/user_info/backend/user_info_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/auth_result.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  //final _profileImageStorage = const ProfileImageStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> login({
    required String email,
    required String passwd,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.login(
      email: email,
      passwd: passwd,
    );
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    }
  }

  Future<void> createAccount({
    required String email,
    required String passwd,
    required String username,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.createAccount(
      email: email,
      passwd: passwd,
    );
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
        username: username,
        email: email,
      );
      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    }
  }

  Future<bool> saveUserInfo({
    required UserId userId,
    required String username,
    required String email,
  }) async {
    final userInfo = await _userInfoStorage.saveUserInfo(
      userId: userId,
      username: username,
      email: _authenticator.email,
    );
    if (userInfo) {
      return true;
    } else {
      return false;
    }
  }
}
