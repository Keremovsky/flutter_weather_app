import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/common/loading_indicator.dart';
import 'package:flutter_weather_app/core/state_notifiers/saved_cities_notifier.dart';
import 'package:flutter_weather_app/features/weather/widgets/saved_cities/saved_city_weather_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/city_weather.dart';
import '../../controller/weather_controller.dart';

class SavedCities extends ConsumerStatefulWidget {
  const SavedCities({super.key});

  @override
  ConsumerState<SavedCities> createState() => _SavedCitiesState();
}

class _SavedCitiesState extends ConsumerState<SavedCities> {
  // variable to hold city's weather data
  late Future<List<CityWeather>> weather;
  // variable to hold saved cities
  late List<String> savedCities;

  // get weather data based on saved cities
  Future<List<CityWeather>> _getSavedCitiesWeather(List<String> cities) async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getSavedCitiesWeather(context, cities);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    savedCities = ref.watch(savedCitiesNotifierProvider);
    _updateSavedCities(savedCities);

    return FutureBuilder(
      future: weather,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        // while fetching data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: LoadingIndicator());
        }

        final data = snapshot.data!;

        // if there is no data
        if (data.isEmpty) {
          return const Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text("No saved city :("),
                  ),
                ),
              ],
            ),
          );
        }
        // if data received
        else {
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
              ],
            ),
          );
        }
      },
    );
  }

  // update saved cities
  void _updateSavedCities(List<String> cities) {
    weather = _getSavedCitiesWeather(cities);
  }
}
