import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/state_notifiers/notification_cities_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              notificationCities == []
                  ? const Text(
                      "This will delete all Notification Cities!",
                      style: TextStyle(fontSize: 16),
                    )
                  : Text(
                      "This will delete ${notificationCities[0]}'s notification!",
                      style: const TextStyle(fontSize: 16),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(notificationStateNotifierProvider.notifier)
                          .setNotificationCity(notificationCities);

                      Navigator.of(context).pop();
                    },
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () {
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
