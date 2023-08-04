import 'package:flutter/material.dart';

class Constants {
  // saveable cities
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

  // temperature drop down items
  static final tempDropDownItems = [
    const DropdownMenuItem(value: "C", child: Text("C")),
    const DropdownMenuItem(value: "K", child: Text("K")),
  ];

  // pressure drop down items
  static final pressureDropDownItems = [
    const DropdownMenuItem(value: "hPa", child: Text("hPa")),
    const DropdownMenuItem(value: "bar", child: Text("bar")),
    const DropdownMenuItem(value: "mmHg", child: Text("mmHg")),
  ];

  // wind speed drop down items
  static final windDropDownItems = [
    const DropdownMenuItem(value: "m/s", child: Text("m/s")),
    const DropdownMenuItem(value: "km/h", child: Text("km/h")),
    const DropdownMenuItem(value: "mph", child: Text("mph")),
    const DropdownMenuItem(value: "knots", child: Text("knots")),
  ];

  // time format drop down items
  static final timeDropDownItems = [
    const DropdownMenuItem(value: "12", child: Text("12")),
    const DropdownMenuItem(value: "24", child: Text("24")),
  ];
}
