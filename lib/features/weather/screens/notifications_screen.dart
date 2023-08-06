import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/notification/controller/notification_controller.dart';

class NotificationsScreen extends ConsumerWidget {
  static final routeName = "/notificationsScreen";

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(notificationControllerProvider.notifier)
                      .setScheduleNotification(
                        context,
                        "Kırklareli",
                        const Duration(seconds: 10),
                        10,
                      );
                },
                child: const Text("Notification"),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(notificationControllerProvider.notifier)
                      .removeScheduleNotification(context, 0);
                },
                child: const Text("Remove Notification"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
