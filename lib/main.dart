import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/firebase_options.dart';
import 'package:ncbae/splash/splash_screen.dart';
import 'package:ncbae/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Ncbae());
}

class Ncbae extends StatelessWidget {
  const Ncbae({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const SplashScreen(),
    );
  }
}
