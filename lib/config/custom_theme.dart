import 'package:flutter/material.dart';

class CustomTheme {
  static TextTheme textTheme(BuildContext context) {
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
    );
  }

  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.white,
      textTheme: textTheme(context),
    );
  }
}
