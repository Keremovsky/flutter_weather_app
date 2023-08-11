import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/city_weather.dart';

class WeatherCalendarScreen extends StatefulWidget {
  final List<CityWeather> cityWeather;

  const WeatherCalendarScreen({required this.cityWeather, super.key});

  @override
  State<WeatherCalendarScreen> createState() => _WeatherCalendarScreenState();
}

class _WeatherCalendarScreenState extends State<WeatherCalendarScreen> {
  double offSetX = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
