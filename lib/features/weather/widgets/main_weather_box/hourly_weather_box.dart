import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/features/weather/widgets/weather_details_box.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import '../../../../core/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils.dart';

class HourlyWeatherBox extends ConsumerWidget {
  final CityWeather cityWeather;

  const HourlyWeatherBox({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitSetting = ref.watch(unitSettingNotifierProvider);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // get city weather details
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            showDragHandle: true,
            isScrollControlled: true,
            builder: (context) {
              return WeatherDetailsBox(
                cityWeather: cityWeather,
                unitSetting: unitSetting,
              );
            },
          );
        },
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
                getTemperature(unitSetting.tempUnit, cityWeather.temp),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
