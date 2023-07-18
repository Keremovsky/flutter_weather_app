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
      final result = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$currentCity,&APPID=$_apiKey"),
      );
      final data = jsonDecode(result.body);
      data["city"] = currentCity;

      if (data["cod"] != "200") {
        return Left("api_error");
      }
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
