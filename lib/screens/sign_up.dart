import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor4u/authentication/phone_auth.dart';
import 'package:tailor4u/screens/login_screen.dart';
import 'package:tailor4u/screens/otp_screen.dart';
import 'package:another_flushbar/flushbar.dart'; // Add Flushbar package
import 'package:http/http.dart' as http; // Add http package for API calls
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DateTime? currentBackPressTime;

  // Controllers for name and mobile fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final PhoneAuth _phoneAuth = PhoneAuth(); // Instantiate PhoneAuth
  final phoneController = TextEditingController();

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    final timeGap = currentBackPressTime == null
        ? const Duration(seconds: 0)
        : now.difference(currentBackPressTime!);
    const exitDuration = Duration(seconds: 2);

    if (timeGap > exitDuration) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Press back again to exit"),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    } else {
      return true; // Exit the app
    }
  }

  void _sendOtp(String mobile) {
    String mobile = _mobileController.text.trim();

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

  Future<void> _saveUserDetails(String name, String mobnum) async {
    String name = _nameController.text;
    String mobnum = _mobileController.text;

  
    // Construct the API URL with query parameters
    final String apiUrl =
        "https://sxzhq34r-3000.inc1.devtunnels.ms/api/users/create-user?phone_number=$mobnum&name=$name";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name);
        final responseData = jsonDecode(response.body);
        if (responseData['userExists'] == false) {
          // Proceed to send OTP
          _sendOtp(mobnum);
        } else {
          // Handle server-side validation errors
          _showErrorFlushbar(
              responseData['message'] ?? "Failed to save user details");
        }
      } else {
        _showErrorFlushbar("Error saving user details. Please try again.");
      }
    } catch (e) {
      _showErrorFlushbar("An unexpected error occurred. Please try again.");
    }
  }

  void _validateAndNavigate() {
    // Check if both fields are filled and mobile number is 10 digits
    String name = _nameController.text;
    String mobile = _mobileController.text;

    if (name.isEmpty) {
      // Show error if name is empty
      _showErrorFlushbar("Please enter your name");
    } else if (mobile.isEmpty || mobile.length != 10) {
      // Show error if mobile is not valid
      _showErrorFlushbar("Please enter a valid 10-digit mobile number");
    } else {
      _saveUserDetails(name, mobile);
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: const Color(0xFFB235A1), // Background color
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Welcome Sign Up!",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Outfit-Bold',
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Image.asset(
                      'assets/Signup.png',
                      height: 240,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 470,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hello!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit-Medium',
                          color: Color(0xFFB235A1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create Your Account For Customise UR Fit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontFamily: 'Outfit-Regular',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Enter Name TextField
                    TextField(
                      controller: _nameController,
                      style: TextStyle(fontFamily: 'Outfit-Regular'),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Mobile TextField
                    TextField(
                      controller: _mobileController,
                      style: TextStyle(fontFamily: 'Outfit-Regular'),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '+91  ',
                        prefixStyle: const TextStyle(
                          fontFamily: 'Outfit-Regular',
                          fontSize: 18,
                        ),
                        labelText: 'Mobile',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        counterText:
                            "", // This removes the counter text below the TextField
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Get OTP Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFAB2EF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _validateAndNavigate,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontFamily: 'Outfit-Bold',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Or",
                      style: TextStyle(
                        fontFamily: 'Outfit-Regular',
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFFBFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Add Google sign-in logic
                        },
                        icon: Image.asset(
                          'assets/Icons/google_search.png', // Replace with your actual path
                          height: 20, // Adjust the size if needed
                          width: 24,
                        ),
                        label: const Text(
                          "Continue With Google",
                          style: TextStyle(
                            fontFamily: 'Outfit-Bold',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do you have an Account? ",
                          style: TextStyle(
                              fontFamily: 'Outfit-Medium',
                              color: Colors.black54),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MobileVerify(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: 'Outfit-Bold',
                              color: Color(0xFFB235A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
