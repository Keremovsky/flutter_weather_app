import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import '../../../../core/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HourlyWeatherBox extends ConsumerWidget {
  final CityWeather cityWeather;

  const HourlyWeatherBox({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitSetting = ref.watch(unitSettingNotifierProvider);
    int hour =
        int.parse(cityWeather.hour) % int.parse(unitSetting.timeFormatUnit);

    return Card(
      child: SizedBox(
        height: 105,
        width: 105,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "$hour:00",
              style: const TextStyle(fontSize: 15),
            ),
            Icon(
              Constants.weatherIcons[cityWeather.state],
              size: 45,
            ),
            Text(
              "${cityWeather.temp.toString()}⁰${unitSetting.tempUnit}",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
