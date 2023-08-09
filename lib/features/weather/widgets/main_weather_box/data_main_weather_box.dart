import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/constants/constants.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/features/weather/screens/weather_calendar_screen.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import '../../../../core/utils.dart';
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

    final cityWeather = widget.cityData;
    final currentCityWeather = cityWeather[0];

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
                            "${currentCityWeather.cityName} / ${getTemperature(unitSetting.tempUnit, currentCityWeather.temp)}",
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
                                Constants
                                    .weatherIcons[currentCityWeather.state],
                                size: 52.5,
                              ),
                              Text(currentCityWeather.state),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.water_drop,
                                size: 52.5,
                              ),
                              Text("${currentCityWeather.humidity}%"),
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
                                  currentCityWeather.windSpeed,
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
                                  currentCityWeather.pressure,
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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 112.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cityWeather.length,
              itemBuilder: (context, index) {
                if (index == cityWeather.length - 1) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                WeatherCalendarScreen(cityWeather: cityWeather),
                          ),
                        );
                      },
                      child: const SizedBox(
                        height: 105,
                        width: 105,
                        child: Center(
                          child: Icon(
                            Icons.more_horiz,
                            size: 65,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return HourlyWeatherBox(cityWeather: cityWeather[index + 1]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
