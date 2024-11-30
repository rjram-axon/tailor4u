import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;

  /// Sends an OTP to the given phone number.
  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) codeSentCallback,
    required Function(FirebaseAuthException) verificationFailedCallback,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically signs in the user (optional)
        await _auth.signInWithCredential(credential);
        print(
            "User signed in automatically: ${_auth.currentUser?.phoneNumber}");
      },
      verificationFailed: (FirebaseAuthException e) {
        verificationFailedCallback(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        codeSentCallback(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        print("Code auto-retrieval timeout");
      },
    );
  }

  /// Verifies the OTP entered by the user.
  Future<User?> verifyOtp({
    required String smsCode,
  }) async {
    if (_verificationId == null) {
      throw Exception("Verification ID is null. Please request OTP first.");
    }

    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print("User signed in: ${userCredential.user?.phoneNumber}");
      return userCredential.user;
    } catch (e) {
      print("Error verifying OTP: $e");
      return null;
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
    print("User signed out");
  }

  /// Checks if a user is currently signed in.
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
