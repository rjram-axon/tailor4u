import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor4u/screens/login_screen.dart';
import 'package:tailor4u/screens/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Method to check if the user is logged in
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn'); // Check login status

    // If the user is logged in, navigate to the main screen
    if (isLoggedIn == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()), // Replace with your main screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-Screen Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/item1.png', // Replace with your actual image asset
              fit: BoxFit.cover,
            ),
          ),
          // Semi-Transparent Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8), // Semi-transparent overlay
            ),
          ),
          // Foreground Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 350,
              padding: const EdgeInsets.all(50),
              decoration: const BoxDecoration(
                color: Colors.white, // Light yellow background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Blouse Craft",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Outfit-Bold',
                        letterSpacing: 1.8),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // Tagline (Single Line with Word Spacing)
                  Text(
                    "Your Perfect Fit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontFamily: 'Outfit-Medium',
                      letterSpacing: 1, // Added word spacing
                    ),
                    textAlign: TextAlign.center,
                    overflow:
                        TextOverflow.ellipsis, // Ensure it stays single line
                  ),
                  Text(
                    " Just a Click Away.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontFamily: 'Outfit-Medium',
                      letterSpacing: 0.5, // Added word spacing
                    ),
                    textAlign: TextAlign.center,
                    overflow:
                        TextOverflow.ellipsis, // Ensure it stays single line
                  ),
                  const SizedBox(height: 60),
                  // Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFFBFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MobileVerify(),
                          ),
                        );
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          fontFamily: 'Outfit-Bold',
                          fontSize: 16,
                          color: Colors.black,
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
