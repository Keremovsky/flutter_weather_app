import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/common/loading_indicator.dart';
import 'package:flutter_weather_app/features/weather/controller/weather_controller.dart';
import 'package:flutter_weather_app/models/city_info.dart';

import 'hourly_weather_box.dart';

class MainWeatherBox extends ConsumerStatefulWidget {
  const MainWeatherBox({super.key});

  @override
  ConsumerState<MainWeatherBox> createState() => _MainWeatherBoxState();
}

class _MainWeatherBoxState extends ConsumerState<MainWeatherBox> {
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
    return FutureBuilder(
      future: weather,
      builder: (context, snapshot) {
        // while fetching data
        if (snapshot.connectionState == ConnectionState.waiting) {
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
                      child: const LoadingIndicator(),
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const Card(
                          child: SizedBox(
                        height: 105,
                        width: 105,
                        child: LoadingIndicator(),
                      ));
                    },
                  ),
                ),
              ),
            ],
          );
        }

        final data = snapshot.data!;

        // if there is no data
        if (data.isEmpty) {
          return SizedBox(
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Text(
                        "Where are you? I can't see you :(",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

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
                                onPressed: () {},
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
                                  const Icon(
                                    Icons.cloud,
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
                                  Text(currentTime.humidity.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.air,
                                    size: 52.5,
                                  ),
                                  Text(currentTime.speed.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.beach_access,
                                    size: 52.5,
                                  ),
                                  Text(currentTime.pressure.toString()),
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
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return HourlyWeatherBox(cityWeather: data[index + 1]);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
