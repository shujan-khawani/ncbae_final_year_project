import 'package:flutter/material.dart';

// Light Mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.blueGrey.shade800,
    secondary: Colors.grey.shade900,
  ),
);

// Dark Mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.blueGrey.shade800,
    secondary: Colors.grey.shade300,
  ),
);
