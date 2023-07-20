import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/screens/update_saved_city_screen.dart';
import 'package:flutter_weather_app/features/weather/widgets/main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/saved_cities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/city_weather.dart';
import '../controller/weather_controller.dart';

class WeatherHomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/weatherHomeScreen";

  const WeatherHomeScreen({super.key});

  @override
  ConsumerState<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends ConsumerState<WeatherHomeScreen> {
  late Future<List<CityWeather>> mainWeather = getCurrentLocationWeather();
  late Future<List<CityWeather>> savedWeather = getSavedCitiesWeather();

  Future<List<CityWeather>> getSavedCitiesWeather() async {
    final cities = ref.read(savedCities);

    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getSavedCitiesWeather(context, cities);

    return result;
  }

  Future<List<CityWeather>> getCurrentLocationWeather() async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getCurrentLocationWeather(context);

    return result;
  }

  @override
  void initState() {
    super.initState();
    mainWeather = getCurrentLocationWeather();
    savedWeather = getSavedCitiesWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // main city weather
            MainWeatherBox(weather: mainWeather),
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
            SavedCities(weather: savedWeather),
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(UpdateSavedCityScreen.routeName);
                savedWeather = getSavedCitiesWeather();
                setState(() {});
              },
              child: const Text(
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
