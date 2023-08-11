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
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

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

  double opacity = 0;

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
            width: double.infinity,
            child: CustomRefreshIndicator(
              trigger: IndicatorTrigger.trailingEdge,
              indicatorCancelDuration: const Duration(seconds: 1),
              onRefresh: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return WeatherCalendarScreen(cityWeather: cityWeather);
                    },
                  ),
                );
              },
              builder: (context, child, controller) {
                return Stack(
                  children: [
                    if (!controller.isIdle)
                      Positioned(
                        top: 40,
                        right: 10 * controller.value,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: controller.value / 2,
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 35,
                          ),
                        ),
                      ),
                    Transform.translate(
                      offset: Offset(-50.0 * controller.value, 0),
                      child: child,
                    ),
                  ],
                );
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return HourlyWeatherBox(cityWeather: cityWeather[index + 1]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
