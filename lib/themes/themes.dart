import 'package:flutter/material.dart';

class Themes {
  static ThemeData get darkTheme {
    return ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF171924),
          onPrimary: Colors.white,
          secondary: Color(0xFF242B43),
          onSecondary: Colors.white,
          tertiary: Color(0xFFE197FA),
          onTertiary: Colors.white,
          brightness: Brightness.dark,
          background: Color(0xFF131B2D),
          onBackground: Colors.white,
          error: Colors.pink,
          onError: Colors.white,
          surface: Color(0xFF202333),
          onSurface: Colors.white,
          surfaceVariant: Color(0xFF6D7189),
          onSurfaceVariant: Colors.white,
          outline: Color(0xFF3C4052),
        ),
        canvasColor: const Color(0xFF131B2D),
        brightness: Brightness.dark,
        cardTheme: CardTheme(
            clipBehavior: Clip.antiAlias,
            color: const Color(0xFF202333),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFF303449), width: 1.5),
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF933A8F),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
          ),
        ),
        fontFamily: 'Poppins',
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFFF417F),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.5),
          labelMedium: TextStyle(
              color: Colors.white, fontSize: 10, fontFamily: 'Poppins'),
          labelSmall: TextStyle(
              color: Colors.white, fontSize: 8, fontWeight: FontWeight.w300),
          titleMedium: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
          displaySmall: TextStyle(
              color: Color(0xFFA1A9BC),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400),
          displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'),
        ),
        radioTheme: RadioThemeData(
          overlayColor: MaterialStateProperty.all<Color>(
              const Color(0xFFFF417F).withOpacity(0.2)),
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFFFF417F);
            } else if (states.contains(MaterialState.disabled)) {
              return const Color(0x80933A8F);
            } else {
              return const Color(0xFF45495C);
            }
          }),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xFF303449),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1.5, color: Color(0xFF878D9E)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1.5, color: Color(0xFF878D9E)),
          ),
        ));
  }
}
