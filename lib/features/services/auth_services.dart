import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/core/logger/talker.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      talker.info('User logged in successfully.');

      return null;
    } on FirebaseAuthException catch (e, stackTrace) {
      talker.error('Firebase login error', e, stackTrace);

      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email';
        case 'wrong-password':
          return 'Incorrect password';
        case 'network-request-failed':
          return 'Check your internet connection';
        default:
          return 'Login failed. Please try again.';
      }
    } catch (e, stackTrace) {
      talker.error('Unexpected login error', e, stackTrace);
      return 'something went wrong';
    }
  }
}
