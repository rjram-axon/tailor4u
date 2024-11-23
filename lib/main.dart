import 'package:flutter/material.dart';
import 'package:tailor4u/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
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
