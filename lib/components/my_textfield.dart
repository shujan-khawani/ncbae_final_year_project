import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextEditingController controller;
  const MyTextfield({
    super.key,
    required this.labelText,
    required this.obscure,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey), // Default border color
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .primary), // Border color when focused
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
