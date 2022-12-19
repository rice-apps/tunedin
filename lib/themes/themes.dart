import 'package:flutter/material.dart';

class Themes {
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme(
        primary: Color(0xFF171924),
        onPrimary: Colors.white,
        secondary: Color(0xFF202333),
        onSecondary: Colors.white,
        tertiary: Color(0xFF790D30),
        onTertiary: Colors.white,
        brightness: Brightness.dark,
        background: Color(0xFF171924),
        onBackground: Colors.white,
        error: Colors.pink,
        onError: Colors.white,
        surface: Color(0xFF202333),
        onSurface: Colors.white,
      ),
      brightness: Brightness.dark,
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        color: const Color(0xFF202333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color(0xFF303449),
            width: 1.5
          ),
        )
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFF933A8F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.white,
            width: 1.5
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      fontFamily: 'Inter',
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
        displaySmall: TextStyle(
          color: Color(0xFFA1A9BC),
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins'
        ),
      )
    );
  }

}