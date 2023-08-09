import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/city_weather.dart';

class WeatherCalendarScreen extends StatelessWidget {
  final List<CityWeather> cityWeather;

  const WeatherCalendarScreen({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(cityWeather[0].cityName),
        ],
      ),
    );
  }
}
