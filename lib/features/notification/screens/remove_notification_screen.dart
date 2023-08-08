import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/state_notifiers/notification_cities_notifier.dart';
import 'package:flutter_weather_app/features/notification/widgets/city_displayer_card.dart';
import 'package:flutter_weather_app/features/notification/widgets/delete_notification_cities_alert.dart';

class RemoveNotificationScreen extends ConsumerStatefulWidget {
  static const routeName = "removeNotificationsScreen";

  const RemoveNotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RemoveNotificationsScreenState();
}

class _RemoveNotificationsScreenState
    extends ConsumerState<RemoveNotificationScreen> {
  // controller for ListWheelScrollView
  late FixedExtentScrollController controller;

  // list of string for cities with notification
  late List<String> notificationCities;

  @override
  void initState() {
    super.initState();

    // initialize controller
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
                child: notificationCities.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Notification City",
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      )
                    : ListWheelScrollView.useDelegate(
                        controller: controller,
                        itemExtent: 120,
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: notificationCities.length,
                          builder: (context, index) {
                            return CityDisplayCard(
                              notificationCity: notificationCities[index],
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
