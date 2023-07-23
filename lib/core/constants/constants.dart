import 'package:flutter/material.dart';

class Constants {
  // addable cities
  static final List<List<String>> cities = [
    ["London", "en"],
    ["İstanbul", "tr"],
    ["Ankara", "tr"],
    ["Sofia", "bg"],
    ["Madrid", "es"],
    ["New York", "us"],
    ["Baku", "az"],
    ["Moscow", "ru"],
    ["Paris", "fr"],
    ["Tokyo", "jp"],
    ["Berlin", "de"],
    ["Saint Petersburg", "ru"],
    ["Kyoto", "jp"],
    ["Eskişehir", "tr"],
    ["Hamburg", "de"],
    ["Kırklareli", "tr"],
    ["Manchester", "en"],
    ["Barcelona", "es"],
    ["Pleven", "bg"],
    ["Nakhchivan", "az"],
    ["California", "us"],
    ["Toulon", "fr"],
    ["Munich", "de"],
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
