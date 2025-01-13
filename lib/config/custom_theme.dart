import 'package:flutter/material.dart';

class CustomTheme {
  static TextTheme textTheme(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: width * 0.049,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: width * 0.040,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: '',
      ),
      bodySmall: TextStyle(
        fontSize: width * 0.030,
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
