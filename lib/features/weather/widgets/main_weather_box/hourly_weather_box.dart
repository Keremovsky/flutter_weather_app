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

    return Card(
      child: SizedBox(
        height: 105,
        width: 105,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              getHour(unitSetting.timeFormatUnit, cityWeather.hour),
              style: const TextStyle(fontSize: 15),
            ),
            Icon(
              Constants.weatherIcons[cityWeather.state],
              size: 45,
            ),
            Text(
              unitSetting.tempUnit == "K"
                  ? "${(cityWeather.temp)}⁰K"
                  : "${(cityWeather.temp) - 273}⁰C",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

String getHour(String timeUnit, String time) {
  if (timeUnit == "24") {
    return time;
  }

  int hour = int.parse(time.substring(0, 2));
  late String mer;
  if (hour < 12) {
    mer = "AM";
  } else {
    mer = "PM";
  }

  if (hour == 0) {
    time = "12:00 $mer";
  } else {
    time = "0$hour:00 $mer";
  }

  return time;
}
