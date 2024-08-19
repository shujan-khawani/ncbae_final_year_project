import 'package:flutter/material.dart';

/// A widget that wraps its child in a card with a primary color background
/// and a slight elevation.
class TextContainer extends StatelessWidget {
  /// The child widget to be wrapped in the card.
  final Widget child;

  /// Creates a new instance of [TextContainer].
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

/// Example usage:
///
/// TextContainer(
///   child: Text('Hello, World!'),
/// ),
///