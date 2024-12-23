import 'package:flutter/material.dart';

class AppTheme {
  // Define Colors
  static  Color primaryColor = Colors.pinkAccent.withOpacity(0.85) ;
  static const Color primary1Color = Colors.pinkAccent ;

  static const Color secondaryColor = Color(0xFFDFCAC3);

  // Light Theme Colors
  static const Color lightSecondaryColor = Color(0xFF03DAC6);
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color lightTextColor = Color(0xFF212121);

  // Dark Theme Colors
  static const Color darkSecondaryColor = Color(0xFF03DAC6);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkTextColor = Color(0xFFE1E1E1);

  // Define Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white, // Text and icon color in the AppBar
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    hintColor: lightSecondaryColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: lightTextColor),
      bodyMedium: TextStyle(color: lightTextColor),
    ),
  );

  // Define Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    hintColor: darkSecondaryColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: darkTextColor),
      bodyMedium: TextStyle(color: darkTextColor),
    ),
  );
}
