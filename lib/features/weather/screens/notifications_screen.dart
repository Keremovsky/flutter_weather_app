import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/state_notifiers/saved_cities_notifier.dart';
import 'package:flutter_weather_app/features/notification/controller/notification_controller.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  static final routeName = "/notificationsScreen";

  const NotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  late FixedExtentScrollController controller;
  List<String> notCities = ["Current City"];
  late List<String> savedCities;

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController();

    savedCities = ref.read(savedCitiesNotifierProvider);
    notCities.addAll(savedCities);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Select City",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 100,
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 0.9,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: notCities.length,
                builder: (context, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(notCities[index]),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  final selectedCity = notCities[controller.selectedItem];
                  ref
                      .read(notificationControllerProvider.notifier)
                      .setScheduleNotification(
                        context,
                        selectedCity,
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
