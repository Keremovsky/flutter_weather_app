import 'package:flutter/material.dart';

class InfoCreateNotificationAlert extends StatelessWidget {
  final textStyle = const TextStyle(fontSize: 18);

  const InfoCreateNotificationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 370,
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
              "You will not get notification if you don't have internet connection at that moment or didn't give permission to send notification.",
              style: textStyle,
            ),
            Text(
              "If you create new notification for a city with notification, it will overwrite it with new one.",
              style: textStyle,
            ),
            Text(
              "Notifications are creating based on unit settings.",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
