import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/utils.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import '../../../core/constants/constants.dart';

class WeatherDetailsBox extends StatelessWidget {
  final CityWeather cityWeather;
  final UnitSetting unitSetting;

  const WeatherDetailsBox(
      {required this.cityWeather, required this.unitSetting, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "${cityWeather.cityName} Details",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(getHour(unitSetting.timeFormatUnit, cityWeather.hour)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(
                      Constants.weatherIcons[cityWeather.state],
                      size: 52.5,
                    ),
                    Text(cityWeather.state),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 52.5,
                    ),
                    Text("${cityWeather.humidity}%"),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.air,
                      size: 52.5,
                    ),
                    Text(
                      getWindSpeed(
                        unitSetting.windSpeedUnit,
                        cityWeather.windSpeed,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.beach_access,
                      size: 52.5,
                    ),
                    Text(
                      getPressure(
                        unitSetting.pressureUnit,
                        cityWeather.pressure,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
