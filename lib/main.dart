import 'package:flutter/material.dart';
import 'package:ncbae/theme/themes.dart';

import 'login_page.dart';

void main() {
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
      home: LoginPage(),
    );
  }
}
