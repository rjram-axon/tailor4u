import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tailor4u/authentication/phone_auth.dart';
import 'package:tailor4u/screens/otp_screen.dart';

class MobileVerify extends StatefulWidget {
  const MobileVerify({super.key});

  @override
  State<MobileVerify> createState() => _MobileVerifyState();
}

class _MobileVerifyState extends State<MobileVerify> {
  final phoneController = TextEditingController();
  final PhoneAuth _phoneAuth = PhoneAuth(); // Instantiate PhoneAuth

  void _validateAndSendOtp() {
    String mobile = phoneController.text.trim();

    if (mobile.isEmpty || mobile.length != 10) {
      _showErrorFlushbar("Please enter a valid 10-digit mobile number");
    } else {
      String phoneNumber = "+91$mobile"; // Adjust as per your country code
      _phoneAuth.sendOtp(
        phoneNumber: phoneNumber,
        codeSentCallback: (verificationId, resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Otpverfication(
                mobileNumber: mobile,
                verificationId: verificationId,
              ),
            ),
          );
        },
        verificationFailedCallback: (error) {
          _showErrorFlushbar(error.message ?? "OTP verification failed");
        },
      );
    }
  }

  void _showErrorFlushbar(String message) {
    Flushbar(
      message: message,
      backgroundColor: const Color(0xFFE74C3C), // Softer red for a modern look
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 28, // Slightly larger for emphasis
      ),
      duration: const Duration(seconds: 1),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius:
          BorderRadius.circular(12), // Increased corner radius for modern feel
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10), // More balanced margin
      padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20), // Generous padding for a cleaner layout
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15), // Subtle shadow for elegance
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ],
      animationDuration: const Duration(milliseconds: 600), // Smooth animation
      // mainButton: TextButton(
      //   onPressed: () {
      //     // Add any action if needed
      //   },
      //   child: const Text(
      //     'DISMISS',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      shouldIconPulse: false,
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
          // Background Color
          Positioned.fill(
            child: Container(
              color: const Color(0xFFB235A1), // Background color (orange)
            ),
          ),
          // Top Section
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Welcome Back Log In! ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit-Bold',
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 83),
                  // Illustration/Image Placeholder
                  Image.asset(
                    'assets/Login.png', // Replace with your illustration
                    height: 250,
                    width: 250,
                  ),
                ],
              ),
            ),
          ),
          // Bottom Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 330,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white, // Light yellow background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // "Hello!" Text
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hello!",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Outfit-Medium',
                        color: Color(0xFFB235A1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Subtitle Text
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login to UR Account",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Outfit-Regular',
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Mobile Input Field
                  SizedBox(
                    height: 50, // Set exact height from design
                    child: TextField(
                      controller: phoneController,
                      maxLength: 10,
                      style: const TextStyle(fontFamily: 'Outfit-Regular'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '+91  ',
                        prefixStyle: const TextStyle(
                          fontFamily: 'Outfit-Regular',
                          fontSize: 18,
                        ),
                        labelText: 'Mobile',
                        hintText: 'Enter Your Number',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Outfit-Regular',
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        counterText: "",
                        isDense: true, // Ensures compact layout
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                  // "Get OTP" Button
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFAB2EF), // Light Salmon
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _validateAndSendOtp,
                      child: const Text(
                        "Get OTP",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Outfit-Bold'),
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
