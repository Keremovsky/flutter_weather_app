import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/notification/controller/notification_controller.dart';

class DeleteNotificationCitiesAlert extends ConsumerWidget {
  final List<String> notificationCities;

  const DeleteNotificationCitiesAlert({
    required this.notificationCities,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: SizedBox(
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Are you sure?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              notificationCities.length == 1
                  ? const Text(
                      "This will delete selected city!",
                      style: TextStyle(fontSize: 16),
                    )
                  : const Text(
                      "This will delete all Notification Cities!",
                      style: TextStyle(fontSize: 16),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // remove selected notification
                      ref
                          .read(notificationControllerProvider.notifier)
                          .removeScheduleNotification(
                            context,
                            notificationCities,
                          );

                      Navigator.of(context).pop();
                    },
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // don't remove
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
