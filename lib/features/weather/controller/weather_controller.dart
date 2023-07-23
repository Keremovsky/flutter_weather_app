import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:flutter_weather_app/features/weather/repository/weather_repository.dart';
import 'package:intl/intl.dart';

import '../../../models/weather.dart';

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

    List<CityWeather> cityWeather = [];

    result.fold(
      (left) {
        if (left == "api_error") {
          _giveFeedback(context, "There is a problem with OpenWeather.");
        } else if (left == "disabled") {
          _giveFeedback(context, "Location services are not enabled.");
        } else if (left == "no_internet") {
          _giveFeedback(context, "No internet connection :(");
        } else {
          _giveFeedback(context, "Some unknown error occurred.");
        }
      },
      (right) {
        final dataList = right["list"];

        CityWeather cityName;

        final city = right["city"]["name"];
        final country = right["city"]["country"];

        for (int a = 0; a < 7; a++) {
          final parseHour = DateTime.parse(dataList[a]["dt_txt"]);

          final temp = dataList[a]["main"]["temp"].toInt() - 273;
          final state = dataList[a]["weather"][0]["main"];
          final pressure = dataList[a]["main"]["pressure"];
          final humidity = dataList[a]["main"]["humidity"];
          final speed = dataList[a]["wind"]["speed"];
          final hour = DateFormat.H().format(parseHour);

          cityName = CityWeather(
            cityName: city,
            country: country,
            temp: temp,
            state: state,
            pressure: pressure,
            humidity: humidity,
            speed: speed,
            hour: hour,
          );
          cityWeather.add(cityName);
        }
      },
    );

    debugPrint(cityWeather.toString());

    return cityWeather;
  }

  Future<Weather> getWeatherWithLocation(
      BuildContext context, double lat, double lng) async {
    final result = await _weatherRepository.getWeatherWithLocation(lat, lng);

    late Weather weather;
    result.fold(
      (left) {
        if (left == "api_error") {
          _giveFeedback(context, "There is a problem with OpenWeather.");
        } else if (left == "coordinate_error") {
          _giveFeedback(context, "Please use proper latitude and longitude.");
        } else if (left == "no_internet") {
          _giveFeedback(context, "No internet connection :(");
        } else {
          _giveFeedback(context, "Some unknown error occurred.");
        }

        weather = Weather(
          temp: 0,
          state: "fail",
          pressure: 0,
          humidity: 0,
          speed: 0,
          lat: lat,
          lng: lng,
        );
      },
      (right) {
        final temp = right["main"]["temp"].toInt() - 273;
        final state = right["weather"][0]["main"];
        final pressure = right["main"]["pressure"];
        final humidity = right["main"]["humidity"];
        final speed = right["wind"]["speed"];

        weather = Weather(
          temp: temp,
          state: state,
          pressure: pressure,
          humidity: humidity,
          speed: speed,
          lat: lat,
          lng: lng,
        );
      },
    );

    return weather;
  }

  Future<List<CityWeather>> getSavedCitiesWeather(
      BuildContext context, List<String> cities) async {
    final result = await _weatherRepository.getSavedCitiesWeather(cities);

    List<CityWeather> addedCitiesWeather = [];
    result.fold(
      (left) {
        if (left == "api_error") {
          _giveFeedback(context, "There is a problem with OpenWeather.");
        } else if (left == "no_internet") {
          _giveFeedback(context, "No internet connection :(");
        } else {
          _giveFeedback(context, "Some unknown error occurred.");
        }
      },
      (right) {
        CityWeather cityWeather;
        for (Map<String, dynamic> data in right) {
          final dataList = data["list"];

          final parseHour = DateTime.parse(dataList[0]["dt_txt"]);

          final city = data["city"]["name"];
          final country = data["city"]["country"];

          final temp = dataList[0]["main"]["temp"].toInt() - 273;
          final state = dataList[0]["weather"][0]["main"];
          final pressure = dataList[0]["main"]["pressure"];
          final humidity = dataList[0]["main"]["humidity"];
          final speed = dataList[0]["wind"]["speed"];
          final hour = DateFormat.Hm().format(parseHour);

          cityWeather = CityWeather(
            cityName: city,
            country: country,
            temp: temp,
            state: state,
            pressure: pressure,
            humidity: humidity,
            speed: speed,
            hour: hour,
          );

          addedCitiesWeather.add(cityWeather);
        }
      },
    );

    debugPrint(addedCitiesWeather.toString());

    return addedCitiesWeather;
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
