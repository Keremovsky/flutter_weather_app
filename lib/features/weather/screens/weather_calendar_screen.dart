import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/core/utils.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/constants.dart';
import '../widgets/weather_details_box.dart';

class WeatherCalendarScreen extends StatefulWidget {
  final List<CityWeather> cityWeather;

  const WeatherCalendarScreen({required this.cityWeather, super.key});

  @override
  State<WeatherCalendarScreen> createState() => _WeatherCalendarScreenState();
}

class _WeatherCalendarScreenState extends State<WeatherCalendarScreen> {
  List<List<CityWeather>> cityWeathers = [[], [], [], [], [], [], []];

  @override
  void initState() {
    super.initState();

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
                    return CalendarDay(cityWeather: cityWeathers[index]);
                  } else {
                    return CalendarDay(cityWeather: cityWeathers[index]);
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

class CalendarDay extends StatefulWidget {
  final List<CityWeather> cityWeather;

  const CalendarDay({required this.cityWeather, super.key});

  @override
  State<CalendarDay> createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
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
                return CalendarBox(cityWeather: cityWeathers0[index]);
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
                      return CalendarBox(cityWeather: cityWeathers1[index]);
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CalendarBox extends ConsumerWidget {
  final CityWeather cityWeather;

  const CalendarBox({required this.cityWeather, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitSetting = ref.read(unitSettingNotifierProvider);

    return SizedBox(
      width: 80,
      child: Card(
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              useSafeArea: true,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) {
                return WeatherDetailsBox(
                  cityWeather: cityWeather,
                  unitSetting: unitSetting,
                );
              },
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cityWeather.hour),
              Icon(Constants.weatherIcons[cityWeather.state]),
              Text(getTemperature(unitSetting.tempUnit, cityWeather.temp)),
            ],
          ),
        ),
      ),
    );
  }
}
