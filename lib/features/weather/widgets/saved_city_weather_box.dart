import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/constants/constants.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import '../../../models/city_weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedCityWeatherBox extends ConsumerWidget {
  final CityWeather cityWeather;

  const SavedCityWeatherBox({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UnitSetting unitSetting = ref.watch(unitSettingNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
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
                  unitSetting.tempUnit == "K"
                      ? "${(cityWeather.temp)}⁰K"
                      : "${(cityWeather.temp) - 273}⁰C",
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
