import 'package:flutter/material.dart';
import 'package:ncbae/components/logo_image.dart';
import 'package:ncbae/components/text_class.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final selectableText = textClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const LogoImage(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'ABOUT US',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SelectableText(
                    selectableText.aboutUs,
                  ),
                  const Text(
                    'VISION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SelectableText(
                    selectableText.vision,
                  ),
                  const Text(
                    'MISSION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SelectableText(
                    selectableText.mission,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
