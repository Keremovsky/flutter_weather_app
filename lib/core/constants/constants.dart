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

  // countries drop down items
  static const countriesDropDownItems = [
    DropdownMenuItem(value: "", child: Text("No Country")),
    DropdownMenuItem(value: "tr", child: Text("Turkey")),
    DropdownMenuItem(value: "en", child: Text("England")),
    DropdownMenuItem(value: "bg", child: Text("Bulgaria")),
    DropdownMenuItem(value: "es", child: Text("Spain")),
    DropdownMenuItem(value: "az", child: Text("Azerbaijan")),
    DropdownMenuItem(value: "jp", child: Text("Japan")),
    DropdownMenuItem(value: "de", child: Text("Germany")),
    DropdownMenuItem(value: "us", child: Text("USA")),
    DropdownMenuItem(value: "fr", child: Text("France")),
  ];

  // notification schedule time drop down items
  static const notScheduleDropDownItems = [
    DropdownMenuItem(value: "day", child: Text("Daily")),
    DropdownMenuItem(value: "hour", child: Text("Hourly")),
  ];

  // temperature drop down items
  static const tempDropDownItems = [
    DropdownMenuItem(value: "C", child: Text("C")),
    DropdownMenuItem(value: "K", child: Text("K")),
  ];

  // pressure drop down items
  static const pressureDropDownItems = [
    DropdownMenuItem(value: "hPa", child: Text("hPa")),
    DropdownMenuItem(value: "bar", child: Text("bar")),
    DropdownMenuItem(value: "mmHg", child: Text("mmHg")),
  ];

  // wind speed drop down items
  static const windDropDownItems = [
    DropdownMenuItem(value: "m/s", child: Text("m/s")),
    DropdownMenuItem(value: "km/h", child: Text("km/h")),
    DropdownMenuItem(value: "mph", child: Text("mph")),
    DropdownMenuItem(value: "knots", child: Text("knots")),
  ];

  // time format drop down items
  static const timeDropDownItems = [
    DropdownMenuItem(value: "12", child: Text("12")),
    DropdownMenuItem(value: "24", child: Text("24")),
  ];
}
