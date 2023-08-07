import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/state_notifiers/notification_cities_notifier.dart';
import 'package:flutter_weather_app/features/notification/widgets/delete_notification_cities_alert.dart';

class RemoveNotificationsScreen extends ConsumerStatefulWidget {
  static const routeName = "removeNotificationsScreen";

  const RemoveNotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RemoveNotificationsScreenState();
}

class _RemoveNotificationsScreenState
    extends ConsumerState<RemoveNotificationsScreen> {
  late FixedExtentScrollController controller;
  late List<String> notificationCities;

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    notificationCities = ref.watch(notificationStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Remove Notification"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: 120,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: notificationCities.length,
                    builder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                notificationCities[index],
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteNotificationCitiesAlert(
                            notificationCities: notificationCities,
                          );
                        },
                      );
                    },
                    heroTag: null,
                    child: const Icon(Icons.delete_forever),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (notificationCities.isEmpty) {
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (context) {
                          final selectedCities =
                              notificationCities[controller.selectedItem];

                          return DeleteNotificationCitiesAlert(
                            notificationCities: [selectedCities],
                          );
                        },
                      );
                    },
                    heroTag: null,
                    child: const Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
