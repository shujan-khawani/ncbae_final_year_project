/*
 * The main entry point of the NCBAE application.
 *
 * This file initializes the Firebase Core and sets up the material app
 * with a splash screen.
 */
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/firebase_options.dart';
import 'package:ncbae/splash/splash_screen.dart';
import 'package:ncbae/Themes/themes.dart';

/*
 * The main function that initializes the Firebase Core and runs the app.
 */
void main() async {
  /**
   * Ensure that the Flutter binding is initialized before running the app.
   */
  WidgetsFlutterBinding.ensureInitialized();

  /**
   * Initialize the Firebase Core with the default Firebase options for the current platform.
   */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /**
   * Run the NCBAE app.
   */
  runApp(const Ncbae());
}

/*
 * The NCBAE app widget.
 */
class Ncbae extends StatelessWidget {
  /*
   * Creates a new instance of the NCBAE app widget.
   *
   * [key] is an optional key for the widget.
   */
  const Ncbae({super.key});

  @override
  /*
   * Builds the material app with a splash screen and light/dark themes.
   *
   * Returns a [MaterialApp] widget with the following properties:
   * - [debugShowCheckedModeBanner] is set to `false` to hide the debug banner.
   * - [theme] is set to the light theme.
   * - [darkTheme] is set to the dark theme.
   * - [home] is set to the splash screen.
   */
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const SplashScreen(),
    );
  }
}
