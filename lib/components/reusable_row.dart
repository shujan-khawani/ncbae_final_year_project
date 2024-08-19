import 'package:flutter/material.dart';

/// A reusable row widget that displays a title and subtitle with a divider.
///
/// This widget is designed to be used in a list or other layout where a consistent
/// row design is needed. It provides a simple and customizable way to display
/// a title and subtitle with a divider.
///
/// Example:
///
/// ReusableRow(
///   title: 'Title',
///   subtitle: 'Subtitle',
/// )
///
class ReusableRow extends StatelessWidget {
  /// The title to be displayed in the row.
  final String title;

  /// The subtitle to be displayed in the row.
  final String subtitle;

  const ReusableRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subtitle),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
