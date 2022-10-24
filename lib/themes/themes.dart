import 'package:flutter/material.dart';

class Themes {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Color(0xFF1B1B1B),
      brightness: Brightness.dark,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.transparent,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        minWidth: 100,
        height: 45
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        color: Color(0xFF202333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700
        ),
        labelMedium: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontFamily: 'Poppins'
        ),
        labelSmall: TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.w300
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),
        
      )
    );
  }

}