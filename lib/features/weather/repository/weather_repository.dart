import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/api_keys.dart';
import 'package:flutter_weather_app/features/location/controller/location_controller.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

final weatherRepositoryProvider = Provider((ref) => WeatherRepository(
      apiKey: openWeatherApiKey,
      locationController: ref.read(locationControllerProvider.notifier),
    ));

class WeatherRepository {
  final String _apiKey;
  final LocationController _locationController;

  WeatherRepository({required String apiKey, required locationController})
      : _locationController = locationController,
        _apiKey = apiKey;

  Future<Either<String, Map<String, dynamic>>>
      getCurrentLocationWeather() async {
    try {
      final currentCity = await _locationController.getCurrentCity();

      if (currentCity == "disabled" || currentCity == "disabled_forever") {
        return Left(currentCity);
      }

      final result = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$currentCity,&APPID=$_apiKey"),
      );
      final data = jsonDecode(result.body);

      if (data["cod"] != "200") {
        return const Left("api_error");
      }
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getSavedCitiesWeather(
      List<String> cities) async {
    try {
      List<Map<String, dynamic>> datas = [];

      for (String city in cities) {
        final result = await http.get(
          Uri.parse(
              "https://api.openweathermap.org/data/2.5/forecast?q=$city,&APPID=$_apiKey"),
        );
        final data = jsonDecode(result.body);

        datas.add(data);

        if (data["cod"] != "200") {
          return const Left("api_error");
        }
      }

      return Right(datas);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
