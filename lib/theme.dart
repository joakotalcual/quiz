import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(

  fontFamily: GoogleFonts.nunito().fontFamily,


  brightness: Brightness.dark,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 18), // Formerly bodyText1
    displayMedium: TextStyle(fontSize: 16), // Formerly bodyText2
    labelLarge: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ), // Formerly button
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
    ), // Formerly headline6
    titleMedium: TextStyle(
      color: Colors.grey,
    ), // Formerly subtitle2
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.black87,
  ),
);
