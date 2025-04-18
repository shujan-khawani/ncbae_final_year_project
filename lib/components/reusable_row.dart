// ignore_for_file: deprecated_member_use

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
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
