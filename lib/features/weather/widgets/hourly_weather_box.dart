import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/city_weather.dart';

class HourlyWeatherBox extends StatelessWidget {
  CityWeather cityWeather;

  HourlyWeatherBox({required CityWeather cityWeather, super.key})
      : this.cityWeather = cityWeather;

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
              Icons.cloud,
              size: 45,
            ),
            Text(
              "${cityWeather.temp.toString()}⁰C",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
