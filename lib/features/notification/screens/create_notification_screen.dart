import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/constants/constants.dart';
import 'package:flutter_weather_app/features/notification/controller/notification_controller.dart';

class CreateNotificationScreen extends ConsumerStatefulWidget {
  static final routeName = "/createNotificationsScreen";

  const CreateNotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends ConsumerState<CreateNotificationScreen> {
  late FixedExtentScrollController controller;
  List<String> notCities = ["Current City"];
  List<String> allCities = [];
  late String selectedSchedule;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController();

    for (final city in Constants.cities) {
      allCities.add(city[0]);
    }
    notCities.addAll(allCities);

    selectedSchedule = "day";
  }

  @override
  void dispose() {
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
                    childCount: notCities.length,
                    builder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                notCities[index],
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
                      if (selectedTime == null) {
                        const snackBar = SnackBar(
                          content: Text("First select a time."),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }

                      final selectedCity = notCities[controller.selectedItem];

                      if (selectedSchedule == "day") {
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
