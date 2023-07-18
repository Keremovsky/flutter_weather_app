import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/api_keys.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final locationRepositoryProvider = Provider((ref) => LocationRepository());

class LocationRepository {
  Future<String> getCurrentCity() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return "disabled";
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        return "disabled_forever";
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
              "https://api.opencagedata.com/geocode/v1/json?q=$lat+$lng&key=$openCageDataApiKey"),
        );

        final data = jsonDecode(result.body);

        final town = data["results"][0]["components"]["town"];
        if (town != null) return town;

        city = data["results"][0]["components"]["province"];
        debugPrint(city);
      }

      return city;
    } catch (e) {
      return "Error";
    }
  }
}
