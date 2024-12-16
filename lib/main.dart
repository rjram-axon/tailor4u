import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tailor4u/authentication/shared_preferences_util.dart';
import 'package:tailor4u/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized
  await Firebase.initializeApp(); // Initializes Firebase
  await SharedPreferencesUtil.init(); // Initializes SharedPreferences
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug tag
      title: "Tailor4U",
      home: WelcomeScreen(),
    );
  }
}
