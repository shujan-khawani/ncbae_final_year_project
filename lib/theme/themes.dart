import 'package:flutter/material.dart';

// Light Mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFEEEEEE),
    primary: Colors.blueGrey,
    secondary: Color(0xFF212121),
  ),
);

// Dark Mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF212121),
    primary: Colors.blueGrey,
    secondary: Color(0xFFEEEEEE),
  ),
);
