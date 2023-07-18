import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/models/city_info.dart';
import 'package:flutter_weather_app/features/weather/repository/weather_repository.dart';
import 'package:intl/intl.dart';

final weatherControllerProvider =
    StateNotifierProvider((ref) => WeatherController(
          weatherRepository: ref.read(weatherRepositoryProvider),
        ));

class WeatherController extends StateNotifier {
  final WeatherRepository _weatherRepository;

  WeatherController({required weatherRepository})
      : _weatherRepository = weatherRepository,
        super(false);

  Future<List<CityWeather>> getCurrentLocationWeather(
      BuildContext context) async {
    final result = await _weatherRepository.getCurrentLocationWeather();

    List<CityWeather> data = [];

    result.fold(
      (left) {
        if (left == "api_error") {
          if (mounted) {
            _giveFeedback(context, "There is a problem with OpenWeather.");
          }
        } else {
          _giveFeedback(context, left);
        }
      },
      (right) {
        final dataList = right["list"];

        CityWeather cityName;
        for (int a = 0; a < 6; a++) {
          final parseHour = DateTime.parse(dataList[a]["dt_txt"]);

          final temp = (dataList[a]["main"]["temp"].toInt() - 273) ?? 10;
          final state = dataList[a]["weather"][0]["main"];
          final pressure = dataList[a]["main"]["pressure"];
          final humidity = dataList[a]["main"]["humidity"];
          final speed = dataList[a]["wind"]["speed"];
          final hour = DateFormat.Hm().format(parseHour);

          cityName = CityWeather(
            cityName: right["city"],
            temp: temp,
            state: state,
            pressure: pressure,
            humidity: humidity,
            speed: speed,
            hour: hour,
          );
          data.add(cityName);
        }
      },
    );

    return data;
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _giveFeedback(
    BuildContext context, String content) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(content),
    ),
  );
}
