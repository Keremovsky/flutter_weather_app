import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import '../../../../core/constants/constants.dart';

class HourlyWeatherBox extends StatelessWidget {
  final CityWeather cityWeather;

  const HourlyWeatherBox({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 105,
        width: 105,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              cityWeather.hour,
              style: const TextStyle(fontSize: 15),
            ),
            Icon(
              Constants.weatherIcons[cityWeather.state],
              size: 45,
            ),
            Text(
              "${cityWeather.temp.toString()}⁰C",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
