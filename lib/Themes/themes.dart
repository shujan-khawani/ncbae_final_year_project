import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Mode
ThemeData lightMode = ThemeData(
  fontFamily: GoogleFonts.montserrat().fontFamily,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.blueGrey.shade800,
    secondary: Colors.grey.shade900,
    onPrimary: Colors.white,
  ),
);

// Dark Mode
ThemeData darkMode = ThemeData(
  fontFamily: GoogleFonts.montserrat().fontFamily,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.blueGrey.shade800,
    secondary: Colors.grey.shade300,
    onPrimary: Colors.grey.shade300,
  ),
);
