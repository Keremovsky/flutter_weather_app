import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/state_notifiers/theme_notifier.dart';
import 'package:flutter_weather_app/features/notification/screens/notifications_screen.dart';
import 'package:flutter_weather_app/features/weather/screens/location_weather_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/weather/screens/update_saved_city_screen.dart';
import 'package:flutter_weather_app/features/weather/widgets/unit_settings.dart';

// state provider to get switch value based on theme mode
final switchProvider = StateProvider((ref) => false);

class EndDrawer extends ConsumerStatefulWidget {
  const EndDrawer({super.key});

  @override
  ConsumerState<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends ConsumerState<EndDrawer> {
  // variable to get switch value
  late bool switchValue;

  @override
  void initState() {
    super.initState();

    // get switch value
    switchValue = ref.read(switchProvider);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(NotificationsScreen.routeName);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.notifications, size: 26),
                      SizedBox(width: 10),
                      Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
              SizedBox(
                height: 40,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(LocationWeatherScreen.routeName);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.assistant_navigation, size: 26),
                      SizedBox(width: 10),
                      Text(
                        "Get Weather",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
              SizedBox(
                height: 40,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(UpdateSavedCityScreen.routeName);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.location_city, size: 26),
                      SizedBox(width: 10),
                      Text(
                        "Update Saved Cities",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
              SizedBox(
                height: 40,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const UnitSettings();
                        });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.settings, size: 26),
                      SizedBox(width: 10),
                      Text(
                        "Unit Settings",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 30),
              Row(
                children: [
                  const Text(
                    "Change Theme",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Switch(
                    value: switchValue,
                    onChanged: (value) {
                      // update theme and switch
                      switchValue = value;
                      if (switchValue == false) {
                        ref
                            .read(themeNotifierProvider.notifier)
                            .setTheme(ThemeMode.dark);
                      } else {
                        ref
                            .read(themeNotifierProvider.notifier)
                            .setTheme(ThemeMode.light);
                      }

                      ref
                          .read(switchProvider.notifier)
                          .update((state) => switchValue);

                      setState(() {});
                    },
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
