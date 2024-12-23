import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tailor4u/authentication/shared_preferences_util.dart';
import 'package:tailor4u/screens/Profile/settings.dart';
import 'package:tailor4u/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized
  await Firebase.initializeApp(); // Initializes Firebase
  await SharedPreferencesUtil.init(); // Initializes SharedPreferences

  // Load the user's saved theme preference
  String initialTheme = await ThemeNotifier.loadThemePreference();

  runApp(MyApp(initialTheme)); // Pass the loaded theme to MyApp
}

class MyApp extends StatelessWidget {
  final String initialTheme;

  // Constructor to pass the initial theme based on user preference or system default
  MyApp(this.initialTheme);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(initialTheme),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Remove the debug tag
            title: "Tailor4U",
            theme: themeNotifier.themeData, // Apply the theme based on user selection
            home: WelcomeScreen(),
          );
        },
      ),
    );
  }
}
