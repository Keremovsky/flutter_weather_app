import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/constants/constants.dart';
import 'package:flutter_weather_app/core/state_notifiers/saved_cities_notifier.dart';
import 'package:flutter_weather_app/features/weather/widgets/city_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/weather/widgets/delete_saved_cities_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateSavedCityScreen extends ConsumerStatefulWidget {
  static const routeName = "/createSavedCityScreen";

  const UpdateSavedCityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddSavedCityScreenState();
}

class _AddSavedCityScreenState extends ConsumerState<UpdateSavedCityScreen> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final List<List<String>> cityList = Constants.cities;
  List<List<String>> cityListDisplay = Constants.cities;
  late List<String> savedCitiesDisplay;

  String searchValue = "";

  @override
  void initState() {
    super.initState();

    savedCitiesDisplay = ref.read(savedCitiesNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final list = savedCitiesDisplay;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search",
                      ),
                      onChanged: (value) {
                        searchValue = value;
                        cityListDisplay = _applyFilter(
                            cityListDisplay, cityList, searchValue);
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cityListDisplay.length,
                      itemBuilder: (context, index) {
                        bool isSelected =
                            list.contains(cityListDisplay[index][0]);

                        return CityTile(
                          city: cityListDisplay[index][0],
                          country: cityListDisplay[index][1],
                          selectCity: _selectCity,
                          isSelected: isSelected,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return const DeleteAllSavedCitiesAlert();
                          },
                        );
                      },
                      child: const Icon(
                        Icons.delete_forever,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        ref
                            .read(savedCitiesNotifierProvider.notifier)
                            .setSavedCities(savedCitiesDisplay);

                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.check,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCity(WidgetRef ref, String city) {
    if (savedCitiesDisplay.contains(city)) {
      savedCitiesDisplay.remove(city);
    } else {
      savedCitiesDisplay.add(city);
    }

    setState(() {});
  }
}

List<List<String>> _applyFilter(List<List<String>> cityListDisplay,
    List<List<String>> cityList, String searchValue) {
  searchValue = searchValue.toLowerCase();

  String cityName;
  return cityListDisplay = cityList.where((value) {
    cityName = value[0].toLowerCase();
    return cityName.contains(searchValue);
  }).toList();
}
