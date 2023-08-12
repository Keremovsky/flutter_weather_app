import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/widgets/weather_details_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/constants.dart';
import '../../../core/state_notifiers/unit_setting_notifer.dart';
import '../../../core/utils.dart';
import '../../../models/city_weather.dart';

class WeatherCalendarBox extends ConsumerWidget {
  final CityWeather cityWeather;

  const WeatherCalendarBox({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitSetting = ref.read(unitSettingNotifierProvider);

    return SizedBox(
      width: 80,
      child: Card(
        child: InkWell(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cityWeather.hour),
              Icon(Constants.weatherIcons[cityWeather.state]),
              Text(getTemperature(unitSetting.tempUnit, cityWeather.temp)),
            ],
          ),
        ),
      ),
    );
  }
}
