import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/constants/constants.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import '../../controller/weather_controller.dart';
import '../hourly_weather_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataMainWeatherBox extends ConsumerStatefulWidget {
  final Function openEndDrawer;
  final List<CityWeather> cityData;

  const DataMainWeatherBox(
      {required this.openEndDrawer, required this.cityData, super.key});

  @override
  ConsumerState<DataMainWeatherBox> createState() => _MainWeatherBoxState();
}

class _MainWeatherBoxState extends ConsumerState<DataMainWeatherBox> {
  late Future<List<CityWeather>> weather = getCurrentLocationWeather();

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${currentTime.cityName} / ${(currentTime.temp)}⁰C",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              size: 30,
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
                              Text("${currentTime.speed} m/s"),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.beach_access,
                                size: 52.5,
                              ),
                              Text("${currentTime.pressure} hPa"),
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
