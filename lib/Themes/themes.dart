// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Light Mode theme data
///
/// This theme data is used to style the app in light mode.
///
ThemeData lightMode = ThemeData(
  /// Font family used in light mode
  fontFamily: GoogleFonts.outfit().fontFamily,

  /// Material 3
  useMaterial3: true,

  /// Brightness of the theme
  brightness: Brightness.light,

  /// Color scheme used in light mode
  colorScheme: ColorScheme.light(
    /// Background color
    background: Color(0xFFfaf9f6),

    /// Primary color
    primary: Colors.grey.shade300,

    /// Secondary color
    secondary: Colors.grey.shade900,

    /// Color used on primary color
    onPrimary: Colors.white,

    /// Color used on background color
    onBackground: Colors.grey.shade200,
  ),
);

/// Dark Mode theme data
///
/// This theme data is used to style the app in dark mode.
///

ThemeData darkMode = ThemeData(
  /// Font family used in dark mode
  fontFamily: GoogleFonts.outfit().fontFamily,

  /// Material 3
  useMaterial3: true,

  /// Brightness of the theme
  brightness: Brightness.dark,

  /// Color scheme used in dark mode
  colorScheme: ColorScheme.dark(
    /// Background color
    background: Colors.grey.shade900,

    /// Primary color
    primary: Colors.grey.shade800,

    /// Secondary color
    secondary: Colors.grey.shade200,

    /// Color used on primary color
    onPrimary: Colors.grey.shade300,

    /// Color used on background color
    onBackground: Colors.grey.shade700,
  ),
);
