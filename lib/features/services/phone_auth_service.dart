import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/core/logger/talker.dart';

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
