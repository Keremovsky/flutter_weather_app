import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/weather/widgets/main_weather_box/data_main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/main_weather_box/error_main_weather_box.dart';
import 'package:flutter_weather_app/features/weather/widgets/main_weather_box/wait_main_weather_box.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import '../../controller/weather_controller.dart';

class MainWeatherBox extends ConsumerStatefulWidget {
  const MainWeatherBox({super.key});

  @override
  ConsumerState<MainWeatherBox> createState() => _MainWeatherBoxState();
}

class _MainWeatherBoxState extends ConsumerState<MainWeatherBox> {
  // variable to hold city's weather data
  late Future<List<CityWeather>> weather;

  // get weather data based on current location
  Future<List<CityWeather>> getCurrentLocationWeather() async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getCurrentLocationWeather(context);

    return result;
  }

  @override
  void initState() {
    super.initState();

    // get weather data
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
            refresh: _updateMainWeatherBox,
          );
        }

        // if data received
        return DataMainWeatherBox(cityWeathers: data);
      },
    );
  }

  // update weather
  void _updateMainWeatherBox() {
    weather = getCurrentLocationWeather();
    setState(() {});
  }
}
