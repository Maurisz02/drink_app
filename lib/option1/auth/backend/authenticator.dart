import 'package:drink_app/option1/auth/models/auth_result.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String? get email => FirebaseAuth.instance.currentUser?.email;
  String? get username => FirebaseAuth.instance.currentUser?.displayName;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<AuthResult> login({
    required String email,
    required String passwd,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passwd,
      );
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> createAccount({
    required String email,
    required String passwd,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passwd,
      );
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
