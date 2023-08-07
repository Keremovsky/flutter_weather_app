import 'package:flutter/material.dart';

class CityDisplayCard extends StatelessWidget {
  final String notificationCity;

  const CityDisplayCard({required this.notificationCity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notificationCity,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
