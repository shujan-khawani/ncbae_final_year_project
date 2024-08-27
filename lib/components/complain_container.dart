import 'package:flutter/material.dart';

/// A widget that displays a complaint in a card with a title.
///
/// This widget is used to display a single complaint in a list of complaints.
/// It uses the primary color of the theme for the card's background and
/// the onPrimary color for the text.
class ComplaintContainer extends StatelessWidget {
  /// The title of the complaint to be displayed.
  final String title;

  /// Creates a new [ComplaintContainer] with the given [title].
  const ComplaintContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Example usage:
///
/// ```dart
/// ComplaintContainer(title: 'This is a sample complaint');
/// ```