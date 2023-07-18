import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/widgets/hourly_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/saved_city_weather_box.dart';

class WeatherHomeScreen extends StatefulWidget {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // main city weather
              MainWeatherBox(),
              // hourly weather list
              const Divider(),
              // saved cities
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 275,
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
            ],
          ),
        ),
      ),
    );
  }
}
