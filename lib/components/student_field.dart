// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

/// A custom text field widget for student information.
///
/// This widget provides a basic text field with a label, validation, and
/// a controller to manage the input value.
class StudentTextField extends StatelessWidget {
  /// The label text to display above the text field.
  final String labelText;

  /// The text editing controller to manage the input value.
  final TextEditingController controller;

  /// Creates a new instance of [StudentTextField].
  ///
  /// [labelText] is the label text to display above the text field.
  /// [controller] is the text editing controller to manage the input value.
  const StudentTextField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This Field can\'t be Empty';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          controller.text = value;
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Example usage:
///
/// class MyWidget extends StatelessWidget {
///   final _controller = TextEditingController();
///
///   @override
///   Widget build(BuildContext context) {
///     return StudentTextField(
///       labelText: 'Student Name',
///       controller: _controller,
///     );
///   }
/// }
/// 