import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onTap;
  const MyButton({
    super.key,
    required this.buttontext,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
                child: Text(
              buttontext,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.background
                  ),
            )),
          ),
        ));
  }
}
