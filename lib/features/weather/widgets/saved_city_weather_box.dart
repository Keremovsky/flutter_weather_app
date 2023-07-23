import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/constants.dart';
import '../../../models/city_weather.dart';

class SavedCityWeatherBox extends StatelessWidget {
  final CityWeather cityWeather;

  const SavedCityWeatherBox({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Constants.weatherIcons[cityWeather.state],
                      size: 45,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      cityWeather.cityName,
                      style: const TextStyle(
                        fontSize: 22.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${cityWeather.temp}⁰C",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
