import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/constants/constants.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import '../../controller/weather_controller.dart';
import 'hourly_weather_box.dart';

class DataMainWeatherBox extends ConsumerStatefulWidget {
  final List<CityWeather> cityData;

  const DataMainWeatherBox({required this.cityData, super.key});

  @override
  ConsumerState<DataMainWeatherBox> createState() => _MainWeatherBoxState();
}

class _MainWeatherBoxState extends ConsumerState<DataMainWeatherBox> {
  late Future<List<CityWeather>> weather = getCurrentLocationWeather();
  late UnitSetting unitSetting;

  Future<List<CityWeather>> getCurrentLocationWeather() async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getCurrentLocationWeather(context);

    return result;
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    unitSetting = ref.watch(unitSettingNotifierProvider);
    final data = widget.cityData;
    final currentTime = data[0];
    return Column(
      children: [
        SizedBox(
          height: 195,
          width: double.infinity,
          child: Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
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
                            unitSetting.tempUnit == "K"
                                ? "${currentTime.cityName} / ${(currentTime.temp)}⁰K"
                                : "${currentTime.cityName} / ${(currentTime.temp) - 273}⁰C",
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
                                Constants.weatherIcons[currentTime.state],
                                size: 52.5,
                              ),
                              Text(currentTime.state),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.water_drop,
                                size: 52.5,
                              ),
                              Text("${currentTime.humidity}%"),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.air,
                                size: 52.5,
                              ),
                              Text(getWindSpeed(unitSetting.windSpeedUnit,
                                  currentTime.speed)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.beach_access,
                                size: 52.5,
                              ),
                              Text(
                                getPressure(unitSetting.pressureUnit,
                                    currentTime.pressure),
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
        Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 112.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return HourlyWeatherBox(cityWeather: data[index + 1]);
              },
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
