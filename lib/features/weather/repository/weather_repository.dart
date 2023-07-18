import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/api_key.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

final weatherRepositoryProvider = Provider((ref) => WeatherRepository(
      apiKey: apiKey,
    ));

class WeatherRepository {
  final String _apiKey;

  WeatherRepository({required String apiKey}) : _apiKey = apiKey;

  Future<Either<String, Map<String, dynamic>>>
      getCurrentLocationWeather() async {
    try {
      final currentCity = "Kırklareli";
      final result = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$currentCity,&APPID=$_apiKey"),
      );
      final data = jsonDecode(result.body);

      if (data["cod"] != "200") {
        return Left("api_error");
      }
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
