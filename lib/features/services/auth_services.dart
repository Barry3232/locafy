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

  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      talker.info('User successfully created account');
    } on FirebaseAuthException catch (e, stackTrace) {
      talker.error('Registration error', e, stackTrace);
      switch (e.code) {
        case 'email-already-in-use':
          return 'An account already exists with this email';
        case 'weak-password':
          return 'Password should be at least 6 characters';
        case 'network-request-failed':
          return 'Check your internet connection';
        default:
          return 'Registration failed. Please try again.';
      }
    } catch (e, stackTrace) {
      talker.error('Unexpected registration error', e, stackTrace);
      return 'An unexpected error occurred';
    }
    return null;
  }
}
