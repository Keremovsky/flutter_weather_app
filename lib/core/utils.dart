// get temperature based on unit setting
String getTemperature(String tempUnit, int temp) {
  if (tempUnit == "K") {
    return "$temp⁰K";
  } else {
    return "${temp - 273}⁰C";
  }
}

// get pressure based on unit setting
String getPressure(String pressureUnit, int pressure) {
  if (pressureUnit == "mmHg") {
    double newPressure = pressure / 0.751;
    return "${newPressure.toStringAsFixed(0)} $pressureUnit";
  } else if (pressureUnit == "bar") {
    return "${(pressure / 1000).toStringAsFixed(2)} $pressureUnit";
  } else {
    return "$pressure $pressureUnit";
  }
}

// get wind speed based on unit setting
String getWindSpeed(String windSpeedUnit, num windSpeed) {
  if (windSpeedUnit == "m/s") {
    return "$windSpeed $windSpeedUnit";
  } else if (windSpeedUnit == "km/h") {
    windSpeed = windSpeed * (10 / 36);
    return "${windSpeed.toStringAsFixed(2)} $windSpeedUnit";
  } else if (windSpeedUnit == "knots") {
    windSpeed = windSpeed * 1.943;
    return "${windSpeed.toStringAsFixed(2)} $windSpeedUnit";
  } else {
    windSpeed = windSpeed * 2.236;
    return "${windSpeed.toStringAsFixed(2)} $windSpeedUnit";
  }
}

// get hour according to unit setting
String getHour(String timeUnit, String time) {
  if (timeUnit == "24") {
    return time;
  }

  int hour = int.parse(time.substring(0, 2));
  late String mer;
  if (hour < 12) {
    mer = "AM";
  } else {
    mer = "PM";
  }

  if (hour == 0) {
    time = "12:00 $mer";
  } else {
    time = "0${hour % 12}:00 $mer";
  }

  return time;
}
