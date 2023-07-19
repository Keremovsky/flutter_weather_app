import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/screens/create_saved_city_screen.dart';
import 'package:flutter_weather_app/features/weather/widgets/main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/saved_city_weather_box.dart';

class WeatherHomeScreen extends StatefulWidget {
  static const routeName = "/weatherHomeScreen";

  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // main city weather
            const MainWeatherBox(),
            const Divider(),
            // saved cities title
            const Padding(
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
            Expanded(
              child: ListView(
                children: [
                  SavedCityWeatherBox(),
                  SavedCityWeatherBox(),
                  SavedCityWeatherBox(),
                  SavedCityWeatherBox(),
                  SavedCityWeatherBox(),
                  SavedCityWeatherBox(),
                  SavedCityWeatherBox(),
                  SavedCityWeatherBox(),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add new city",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
