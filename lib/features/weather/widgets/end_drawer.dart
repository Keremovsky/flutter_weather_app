import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/screens/location_weather_screen.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  bool switchValue = false;

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
                child: GestureDetector(
                  onTap: () {},
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
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                height: 40,
                child: GestureDetector(
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
              const Spacer(
                flex: 30,
              ),
              Row(
                children: [
                  const Text(
                    "Change Theme",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Switch(
                    value: switchValue,
                    onChanged: (value) {
                      switchValue = value;
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
