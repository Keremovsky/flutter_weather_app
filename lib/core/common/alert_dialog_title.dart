import 'package:flutter/material.dart';

class AlertDialogTitle extends StatelessWidget {
  final String text;

  const AlertDialogTitle({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
