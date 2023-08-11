import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  late ScrollController scrollController;
  scrollListener() {
    double currentOffset = scrollController.offset;
    double maxOffset = scrollController.position.maxScrollExtent;

    double percent = (currentOffset / maxOffset) * 100;

    pullPosition = 30 * (percent * 0.01);
    if (percent > 90) {
      pullOpacity = percent * 0.01;
      if (percent == 100) {
        Future.delayed(const Duration(milliseconds: 300)).then((value) async {
          if (percent == 100 &&
              scrollController.position.isScrollingNotifier.value) {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    WeatherCalendarScreen(cityWeather: widget.cityData),
              ),
            );
            scrollController.animateTo(
              currentOffset * 0,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          } else {
            scrollController.animateTo(
              currentOffset * 0.83,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          }
        });
      }
    } else {
      pullOpacity = 0;
    }
    setState(() {});
  }

  double pullOpacity = 0;
  double pullPosition = -20;

  Future<List<CityWeather>> getCurrentLocationWeather() async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getCurrentLocationWeather(context);

    return result;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    weather = getCurrentLocationWeather();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    unitSetting = ref.watch(unitSettingNotifierProvider);

    final cityWeather = widget.cityData;
    final currentCityWeather = cityWeather[0];

    return Stack(
      children: [
        Column(
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
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  itemCount: cityWeather.length,
                  itemBuilder: (context, index) {
                    if (index == cityWeather.length - 1) {
                      return const SizedBox(width: 70);
                    }
                    return HourlyWeatherBox(
                        cityWeather: cityWeather[index + 1]);
                  },
                ),
              ),
            ),
          ],
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          top: 255,
          right: pullPosition,
          child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: pullOpacity,
              child: Icon(Icons.arrow_forward_ios)),
        ),
      ],
    );
  }
}
