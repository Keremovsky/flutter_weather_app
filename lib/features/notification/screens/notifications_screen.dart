import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/notification/screens/create_notification_screen.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = "/notificationsScreen";

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CreateNotificationScreen.routeName);
                  },
                  child: const Text("Create Notification"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Remove Notification"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
