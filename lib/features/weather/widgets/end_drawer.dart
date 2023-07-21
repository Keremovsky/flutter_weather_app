import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/screens/get_location_weather_screen.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(LocationWeatherScreen.routeName);
                      },
                      borderRadius: BorderRadius.circular(10),
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: const Row(
                        children: [
                          Icon(Icons.delete_forever, size: 26),
                          SizedBox(width: 10),
                          Text(
                            "Delete Saved Cities",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
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
