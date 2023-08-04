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

  // getting name of current city name
  Future<String> getCurrentCity() async {
    try {
      // control if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // if it is not get city name with ip
        final result = await http.get(Uri.parse("http://ip-api.com/json"));
        final data = jsonDecode(result.body);

        return data["regionName"];
      }

      // control if app has permission to get location
      LocationPermission permission = await Geolocator.checkPermission();
      // if no permission, ask user to give permission
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // if user denied, get city name with ip
      if (permission == LocationPermission.deniedForever) {
        final result = await http.get(Uri.parse("http://ip-api.com/json"));
        final data = jsonDecode(result.body);

        return data["regionName"];
      }

      late String city;
      Position currentPosition;
      // if permission taken, get current location
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        double lat = currentPosition.latitude;
        double lng = currentPosition.longitude;

        // get data of current location
        final result = await http.get(
          Uri.parse(
              "https://api.opencagedata.com/geocode/v1/json?q=$lat+$lng&key=$_apiKey"),
        );
        final data = jsonDecode(result.body);

        // get city name with open cage data api
        if (data["results"][0]["components"].containsKey("town")) {
          city = data["results"][0]["components"]["town"];
          return city;
        } else if (data["results"][0]["components"].containsKey("province")) {
          city = data["results"][0]["components"]["province"];
          return city;
        } else if (data["results"][0]["components"].containsKey("city")) {
          city = data["results"][0]["components"]["city"];
          return city;
        } else {
          city = data["results"][0]["components"]["state"];
        }
      }

      return city;
    } catch (e) {
      return "error";
    }
  }
}
