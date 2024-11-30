import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tailor4u/screens/main_screen.dart';

class Otpverfication extends StatefulWidget {
  final String mobileNumber;
  final String verificationId; // Added verificationId parameter

  const Otpverfication({
    super.key,
    required this.mobileNumber,
    required this.verificationId, // Marked as required
  });

  @override
  State<Otpverfication> createState() => _OtpverficationState();
}

class _OtpverficationState extends State<Otpverfication> {
  final TextEditingController _otpController = TextEditingController();

  void _validateAndNavigate() async {
    String otp = _otpController.text;

    // Validate that OTP is 6 digits long
    if (otp.isEmpty || otp.length != 6) {
      _showErrorFlushbar("Please enter a valid 6-digit OTP");
      return;
    }

    // Retrieve the verificationId passed from the previous screen
    final String verificationId = widget.verificationId;

    try {
      // Create a PhoneAuthCredential with the verificationId and the entered OTP
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Successfully signed in
      print("User signed in: ${userCredential.user?.phoneNumber}");

      // Navigate to the MainPage upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } catch (e) {
      // Handle OTP verification failure
      print("Error verifying OTP: $e");
      _showErrorFlushbar("Failed to verify OTP. Please try again.");
    }
  }

  void _showErrorFlushbar(String message) {
    Flushbar(
      message: message,
      backgroundColor: const Color(0xFFE74C3C),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 28,
      ),
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ],
      animationDuration: const Duration(milliseconds: 600),
      titleText: const Text(
        'Error',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(0xFFB235A1),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 88),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Need OTP For LOGIN!! ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit-Bold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 57),
                  Image.asset(
                    'assets/OTP.png',
                    height: 250,
                    width: 250,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 380,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Verify your mobile number',
                    style: TextStyle(
                      fontFamily: 'Outfit-Bold',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter the OTP sent to your mobile number",
                    style: TextStyle(
                      fontFamily: 'Outfit-Medium',
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '+91 ${widget.mobileNumber}',
                    style: const TextStyle(
                      fontFamily: 'Outfit-Medium',
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Pinput(
                      controller: _otpController,
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFB235A1),
                          ),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Outfit-Medium',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFAB2EF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: _validateAndNavigate,
                      child: const Text(
                        'Verify and Continue',
                        style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Didn't receive OTP?",
                      style: TextStyle(
                        fontFamily: 'Outfit-Medium',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        // Handle OTP resend
                      },
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(
                          fontFamily: 'Outfit-Bold',
                          fontSize: 14,
                          color: Color(0xFFB235A1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}