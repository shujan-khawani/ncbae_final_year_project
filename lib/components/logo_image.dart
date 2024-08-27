import 'package:flutter/material.dart';

/// A widget that displays a logo image with a rounded corner.
///
/// The logo image is displayed with a width that fills the available space,
/// and a height that is scaled to maintain the aspect ratio of the image.
///
class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: double.infinity,
        child: Image.asset(
          'images/Login image.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
