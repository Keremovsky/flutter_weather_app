import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/constants/constants.dart';
import 'package:flutter_weather_app/features/weather/widgets/current_weather_box/data_main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/current_weather_box/error_main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/current_weather_box/wait_main_weather_box.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import '../controller/weather_controller.dart';
import 'hourly_weather_box.dart';

class MainWeatherBox extends ConsumerStatefulWidget {
  final Function openEndDrawer;

  const MainWeatherBox({required this.openEndDrawer, super.key});

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
          return const WaitMainWeatherBox();
        }

        final data = snapshot.data!;

        // if there is no data
        if (data.isEmpty) {
          return ErrorMainWeatherData(
            refresh: _refresh,
            openEndDrawer: widget.openEndDrawer,
          );
        }

        return DataMainWeatherBox(
            openEndDrawer: widget.openEndDrawer, cityData: data);
      },
    );
  }

  void _refresh() {
    weather = getCurrentLocationWeather();
    setState(() {});
  }
}
