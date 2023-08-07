import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/state_notifiers/notification_cities_notifier.dart';

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
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                    onPressed: () {},
                    heroTag: null,
                    child: const Icon(Icons.delete_forever),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
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
