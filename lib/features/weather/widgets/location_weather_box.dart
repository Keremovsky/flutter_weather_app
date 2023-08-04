import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import '../../../core/constants/constants.dart';
import '../../../models/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationWeatherBox extends ConsumerWidget {
  final Weather weather;

  const LocationWeatherBox({required this.weather, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (weather.state == "wait") {
      return Column(
        children: [
          SizedBox(
            height: 195,
            width: double.infinity,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 25,
                    sigmaY: 25,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bedtime),
                        SizedBox(height: 15),
                        Text(
                          "I am waiting...",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (weather.state == "fail") {
      return Column(
        children: [
          SizedBox(
            height: 195,
            width: double.infinity,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 25,
                    sigmaY: 25,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error),
                        SizedBox(height: 15),
                        Text(
                          "ERROR!!!",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    UnitSetting unitSetting = ref.watch(unitSettingNotifierProvider);
    return Column(
      children: [
        SizedBox(
          height: 195,
          width: double.infinity,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 25,
                  sigmaY: 25,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        unitSetting.tempUnit == "K"
                            ? "${(weather.temp)}⁰K"
                            : "${(weather.temp) - 273}⁰C",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Constants.weatherIcons[weather.state],
                                size: 52.5,
                              ),
                              Text(weather.state),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.water_drop,
                                size: 52.5,
                              ),
                              Text("${weather.humidity}%"),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.air,
                                size: 52.5,
                              ),
                              Text(getWindSpeed(
                                  unitSetting.windSpeedUnit, weather.speed)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.beach_access,
                                size: 52.5,
                              ),
                              Text(getPressure(
                                  unitSetting.pressureUnit, weather.pressure)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// get pressure based on unit setting
String getPressure(String pressureUnit, int pressure) {
  if (pressureUnit == "mmHg") {
    double newPressure = pressure / 0.751;
    return "${newPressure.toStringAsFixed(0)} $pressureUnit";
  } else if (pressureUnit == "bar") {
    return "${(pressure / 1000).toStringAsFixed(2)} $pressureUnit";
  } else {
    return "$pressure $pressureUnit";
  }
}

// get wind speed based on unit setting
String getWindSpeed(String windSpeedUnit, num windSpeed) {
  if (windSpeedUnit == "m/s") {
    return "$windSpeed $windSpeedUnit";
  } else if (windSpeedUnit == "km/h") {
    windSpeed = windSpeed * (10 / 36);
    return "${windSpeed.toStringAsFixed(2)} $windSpeedUnit";
  } else if (windSpeedUnit == "knots") {
    windSpeed = windSpeed * 1.943;
    return "${windSpeed.toStringAsFixed(2)} $windSpeedUnit";
  } else {
    windSpeed = windSpeed * 2.236;
    return "${windSpeed.toStringAsFixed(2)} $windSpeedUnit";
  }
}
