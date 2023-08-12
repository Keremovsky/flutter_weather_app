import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/core/utils.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/constants/constants.dart';
import '../../../models/weather.dart';

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
                      Row(
                        children: [
                          Text(
                            "${weather.cityName} / ${getTemperature(unitSetting.tempUnit, weather.temp)}",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                              Text(
                                getWindSpeed(
                                    unitSetting.windSpeedUnit, weather.speed),
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
                                    unitSetting.pressureUnit, weather.pressure),
                              ),
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
