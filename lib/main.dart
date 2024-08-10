import 'dart:async';

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

class Ncbae extends StatefulWidget {
  const Ncbae({super.key});

  @override
  State<Ncbae> createState() => _NcbaeState();
}

class _NcbaeState extends State<Ncbae> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      setState(() {});
    });
  }

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
