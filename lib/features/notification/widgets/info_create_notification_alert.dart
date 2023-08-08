import 'package:flutter/material.dart';

class InfoCreateNotificationAlert extends StatelessWidget {
  final textStyle = const TextStyle(fontSize: 18);

  const InfoCreateNotificationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "- You will not get notification if you don't have internet connection at that moment or didn't give permission to send notification.",
              style: textStyle,
            ),
            Text(
              "- If you create new notification for a city that already has notification, it will overwrite that notification with new one.",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
