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

  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          talker.info('Auto verification complete');
        },
        verificationFailed: (FirebaseAuthException e) {
          talker.error('Phone verification failed', e, e.stackTrace);
          onVerificationError(e.message ?? 'Phone verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          talker.info('Otp code sent');
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationid) {
          talker.info('Auto retrieval timeout');
        },
      );
    } catch (e, stackTrace) {
      talker.error('Unexpected phone auth error', e, stackTrace);
      onVerificationError('Something went wrong');
    }
  }
}
