import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/constants/api_keys.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final locationRepositoryProvider =
    Provider((ref) => LocationRepository(apiKey: openCageDataApiKey));

class LocationRepository {
  final String _apiKey;

  LocationRepository({required apiKey}) : _apiKey = apiKey;

  Future<String> getCurrentCity() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        final result = await http.get(Uri.parse("http://ip-api.com/json"));
        final data = jsonDecode(result.body);

        return data["regionName"];
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        final result = await http.get(Uri.parse("http://ip-api.com/json"));
        final data = jsonDecode(result.body);

        return data["regionName"];
      }

      late String city;

      Position currentPosition;
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        double lat = currentPosition.latitude;
        double lng = currentPosition.longitude;

        final result = await http.get(
          Uri.parse(
              "https://api.opencagedata.com/geocode/v1/json?q=$lat+$lng&key=$_apiKey"),
        );

        final data = jsonDecode(result.body);

        if (data["results"][0]["components"].containsKey("town")) {
          city = data["results"][0]["components"]["town"];
          return city;
        }

        if (data["results"][0]["components"].containsKey("province")) {
          city = data["results"][0]["components"]["province"];
          return city;
        }

        if (data["results"][0]["components"].containsKey("city")) {
          city = data["results"][0]["components"]["city"];
          return city;
        }

        city = data["results"][0]["components"]["state"];
      }

      return city;
    } catch (e) {
      return "error";
    }
  }
}
