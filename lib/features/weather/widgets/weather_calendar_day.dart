import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/widgets/weather_calendar_box.dart';
import '../../../models/city_weather.dart';

class WeatherCalendarDay extends StatefulWidget {
  final List<CityWeather> cityWeather;

  const WeatherCalendarDay({required this.cityWeather, super.key});

  @override
  State<WeatherCalendarDay> createState() => _WeatherCalendarDayState();
}

class _WeatherCalendarDayState extends State<WeatherCalendarDay> {
  List<CityWeather> cityWeathers0 = [];
  List<CityWeather> cityWeathers1 = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.cityWeather.length; i++) {
      i < 4
          ? cityWeathers0.add(widget.cityWeather[i])
          : cityWeathers1.add(widget.cityWeather[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            widget.cityWeather[0].date,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 80,
            width: 320,
            child: ListView.builder(
              itemCount: cityWeathers0.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return WeatherCalendarBox(cityWeather: cityWeathers0[index]);
              },
            ),
          ),
          cityWeathers1.isNotEmpty
              ? SizedBox(
                  height: 80,
                  width: 320,
                  child: ListView.builder(
                    itemCount: cityWeathers1.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return WeatherCalendarBox(
                          cityWeather: cityWeathers1[index]);
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
