import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/constants/constants.dart';
import 'package:flutter_weather_app/features/notification/controller/notification_controller.dart';

import '../widgets/city_displayer_card.dart';

class CreateNotificationScreen extends ConsumerStatefulWidget {
  static final routeName = "/createNotificationsScreen";

  const CreateNotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends ConsumerState<CreateNotificationScreen> {
  // controller for ListWheelScrollView
  late FixedExtentScrollController controller;

  // list of cities
  List<String> notificationCities = ["Current City"];
  List<String> allCities = [];

  // for selection
  late String selectedSchedule;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();

    // initialize controller
    controller = FixedExtentScrollController();

    // get all saved cities
    for (final city in Constants.cities) {
      allCities.add(city[0]);
    }
    // get all cities together
    notificationCities.addAll(allCities);

    // give selectedSchedule a predefined value
    selectedSchedule = "day";
  }

  @override
  void dispose() {
    // dispose controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Notification"),
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
                      return CityDisplayCard(
                        notificationCity: notificationCities[index],
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: selectedSchedule == "day" ? 40 : 0,
                    child: ElevatedButton(
                      onPressed: () async {
                        selectedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime ?? TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dialOnly,
                            ) ??
                            TimeOfDay.now();
                      },
                      child: const Text("Select Time"),
                    ),
                  ),
                  DropdownButton(
                    value: selectedSchedule,
                    items: Constants.notScheduleDropDownItems,
                    onChanged: (value) {
                      setState(() {
                        selectedSchedule = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      final selectedCity =
                          notificationCities[controller.selectedItem];

                      if (selectedSchedule == "day") {
                        if (selectedTime == null) {
                          const snackBar = SnackBar(
                            content: Text("First select a time."),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }

                        ref
                            .read(notificationControllerProvider.notifier)
                            .setScheduleNotification(
                              context,
                              selectedCity,
                              const Duration(days: 1),
                              selectedTime!.hour,
                            );
                      } else {
                        ref
                            .read(notificationControllerProvider.notifier)
                            .setScheduleNotification(
                              context,
                              selectedCity,
                              const Duration(hours: 1),
                              TimeOfDay.now().hour,
                            );
                      }
                    },
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
