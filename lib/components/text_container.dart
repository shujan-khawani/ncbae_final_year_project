import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final Widget child;
  const TextContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        elevation: 10,
        color: Theme.of(context).colorScheme.primary,
        child: child,
      ),
    );
  }
}
