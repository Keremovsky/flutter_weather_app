import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import '../widgets/weather_calendar_day.dart';

class WeatherCalendarScreen extends StatefulWidget {
  final List<CityWeather> cityWeather;

  const WeatherCalendarScreen({required this.cityWeather, super.key});

  @override
  State<WeatherCalendarScreen> createState() => _WeatherCalendarScreenState();
}

class _WeatherCalendarScreenState extends State<WeatherCalendarScreen> {
  // variable to divide city weather data to parts
  List<List<CityWeather>> cityWeathers = [[], [], [], [], [], [], []];

  @override
  void initState() {
    super.initState();

    // get city weather data together
    int counter = 0;
    for (int i = 0; i < 40; i++) {
      cityWeathers[counter].add(widget.cityWeather[i]);
      if (widget.cityWeather[i].hour == "21:00") {
        counter++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Calendar"),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cityWeathers.length - 1,
                itemBuilder: (context, index) {
                  if (cityWeathers[cityWeathers.length - 1].isNotEmpty) {
                    return WeatherCalendarDay(cityWeather: cityWeathers[index]);
                  } else {
                    return WeatherCalendarDay(cityWeather: cityWeathers[index]);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
