import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/utils.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import '../../../core/constants/constants.dart';

class WeatherDetailsBox extends StatelessWidget {
  final CityWeather cityWeather;
  final UnitSetting unitSetting;

  const WeatherDetailsBox({
    required this.cityWeather,
    required this.unitSetting,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cityWeather.cityName,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        cityWeather.date,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        getHour(unitSetting.timeFormatUnit, cityWeather.hour),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
      ),
    );
  }
}
