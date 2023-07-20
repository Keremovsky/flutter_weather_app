import 'package:flutter/material.dart';
import 'package:flutter_weather_app/common/loading_indicator.dart';
import 'package:flutter_weather_app/features/weather/widgets/saved_city_weather_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/city_weather.dart';

class SavedCities extends ConsumerStatefulWidget {
  Future<List<CityWeather>> weather;

  SavedCities({required this.weather, super.key});

  @override
  ConsumerState<SavedCities> createState() => _SavedCitiesState();
}

class _SavedCitiesState extends ConsumerState<SavedCities> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.weather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: LoadingIndicator());
        }

        final data = snapshot.data!;

        if (data.isEmpty) {
          return const Expanded(child: Center(child: Text("No saved city :(")));
        }

        return Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return SavedCityWeatherBox(cityWeather: data[index]);
            },
          ),
        );
      },
    );
  }
}
