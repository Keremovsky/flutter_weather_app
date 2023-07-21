import 'package:flutter/material.dart';
import 'package:flutter_weather_app/common/loading_indicator.dart';
import 'package:flutter_weather_app/features/weather/widgets/city_tile.dart';
import 'package:flutter_weather_app/features/weather/widgets/saved_city_weather_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/city_weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/weather_controller.dart';
import '../screens/update_saved_city_screen.dart';

class SavedCities extends ConsumerStatefulWidget {
  const SavedCities({super.key});

  @override
  ConsumerState<SavedCities> createState() => _SavedCitiesState();
}

class _SavedCitiesState extends ConsumerState<SavedCities> {
  List<String> savedCities = [];
  late Future<List<CityWeather>> weather = _getSavedCitiesWeather();

  Future<List<CityWeather>> _getSavedCitiesWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final cities = prefs.getStringList("savedCities") ?? [];

    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getSavedCitiesWeather(context, cities);

    return result;
  }

  @override
  void initState() {
    super.initState();
    weather = _getSavedCitiesWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weather,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: LoadingIndicator());
        }

        final data = snapshot.data!;

        if (data.isEmpty) {
          return Expanded(
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text("No saved city :("),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushNamed(UpdateSavedCityScreen.routeName);

                    final prefs = await SharedPreferences.getInstance();
                    savedCities = prefs.getStringList("savedCities") ?? [];

                    weather = _getSavedCitiesWeather();
                    setState(() {});
                  },
                  child: const Text(
                    "Add new city",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SavedCityWeatherBox(cityWeather: data[index]);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context)
                      .pushNamed(UpdateSavedCityScreen.routeName);

                  final prefs = await SharedPreferences.getInstance();
                  savedCities = prefs.getStringList("savedCities") ?? [];

                  weather = _getSavedCitiesWeather();
                  setState(() {});
                },
                child: const Text(
                  "Add new city",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
