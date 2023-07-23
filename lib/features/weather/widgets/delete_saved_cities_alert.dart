import 'package:flutter/material.dart';
import 'package:flutter_weather_app/state_notifiers/saved_cities_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteAllSavedCitiesAlert extends ConsumerWidget {
  const DeleteAllSavedCitiesAlert({super.key});

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
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                "This will delete all Saved Cities!",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(savedCitiesNotifierProvider.notifier)
                          .setSavedCities([]);

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
