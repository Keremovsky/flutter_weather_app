import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/constants/api_keys.dart';
import 'package:flutter_weather_app/features/location/controller/location_controller.dart';
import 'package:riverpod/riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

  // get weather data of current city
  Future<Either<String, Map<String, dynamic>>>
      getCurrentLocationWeather() async {
    try {
      // control if phone has internet connection
      final connection = await _controlConnection();
      if (!connection) return const Left("no_internet");

      // if it has internet connection, get current city's name
      final currentCity = await _locationController.getCurrentCity();

      // if there is a problem with getting city name
      if (currentCity == "error") {
        return Left(currentCity);
      }

      // get weather data based on city name
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

  // get weather data of given coordinates
  Future<Either<String, Map<String, dynamic>>> getWeatherWithLocation(
      double lat, double lng) async {
    try {
      // control if phone has internet connection
      final connection = await _controlConnection();
      if (!connection) return const Left("no_internet");

      // control if coordinates are appropriate
      if (lat < -90 || lat > 90) {
        return const Left("coordinate_error");
      }
      if (lng < -180 || lng > 180) {
        return const Left("coordinate_error");
      }

      final latStr = lat.toString();
      final lngStr = lng.toString();

      // get weather data based on coordinates
      final result = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=$latStr&lon=$lngStr&appid=$_apiKey"),
      );
      var data = jsonDecode(result.body);

      if (data["cod"] != 200) {
        return const Left("api_error");
      }

      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // get weather data of saved cities
  Future<Either<String, List<Map<String, dynamic>>>> getSavedCitiesWeather(
      List<String> cities) async {
    try {
      // control if phone has internet connection
      final connection = await _controlConnection();
      if (!connection) return const Left("no_internet");

      // get weather data based on saved cities
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

// return true if phone has internet connection
Future<bool> _controlConnection() async {
  return await InternetConnectionChecker().hasConnection;
}
