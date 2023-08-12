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
  late Future<List<CityWeather>> weather;
  late List<String> savedCities;

  Future<List<CityWeather>> _updateSavedCitiesWeather(
      List<String> cities) async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getSavedCitiesWeather(context, cities);

    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    savedCities = ref.watch(savedCitiesNotifierProvider);
    _updateSavedCities(savedCities);

    return FutureBuilder(
      future: weather,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: LoadingIndicator());
        }

        final data = snapshot.data!;

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
        } else {
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

  void _updateSavedCities(List<String> cities) {
    weather = _updateSavedCitiesWeather(cities);
  }
}
