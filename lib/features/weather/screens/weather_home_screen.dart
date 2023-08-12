import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/widgets/end_drawer.dart';
import 'package:flutter_weather_app/features/weather/widgets/main_weather_box/main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/saved_cities/saved_cities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherHomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/weatherHomeScreen";

  const WeatherHomeScreen({super.key});

  @override
  ConsumerState<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends ConsumerState<WeatherHomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      endDrawer: const EndDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            const Column(
              children: [
                // main city weather
                MainWeatherBox(),
                Divider(),
                // saved cities title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Saved Cities",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // saved cities
                SavedCities(),
              ],
            ),
            Positioned(
              top: 20,
              right: 15,
              child: IconButton(
                onPressed: () {
                  scaffoldStateKey.currentState!.openEndDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
