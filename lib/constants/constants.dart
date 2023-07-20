import 'package:flutter/material.dart';

class Constants {
  // addable cities
  static final List<String> cities = [
    "London",
    "İstanbul",
    "Ankara",
    "Sofia",
    "Madrid",
    "New York",
  ];

  // weather icon list
  static final Map<String, IconData> weatherIcons = {
    "Thunderstorm": Icons.thunderstorm,
    "Drizzle": Icons.cloudy_snowing,
    "Rain": Icons.snowing,
    "Snow": Icons.ac_unit,
    "Atmosphere": Icons.foggy,
    "Clear": Icons.sunny,
    "Clouds": Icons.cloud,
  };
}
