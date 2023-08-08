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
  // initialize SharedPreferences
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  // scroll controller
  final ScrollController scrollController = ScrollController();

  // for city filtering
  final List<List<String>> cityList = Constants.cities;
  List<List<String>> cityListDisplay = Constants.cities;
  late List<String> savedCitiesDisplay;

  // search strings
  String searchCityName = "";
  String searchCountry = "";

  // change to bottom distance of ListView.builder
  int bottomDistance = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        bottomDistance = 20;
        setState(() {});
      }
    });

    // get saved cities
    savedCitiesDisplay = ref.read(savedCitiesNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final list = savedCitiesDisplay;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Saved Cities"),
        centerTitle: true,
      ),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search",
                            ),
                            onChanged: (value) {
                              // apply filters
                              searchCityName = value;
                              cityListDisplay = _applyFilter(
                                cityListDisplay,
                                cityList,
                                searchCityName,
                                searchCountry,
                              );
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: DropdownButton(
                                    items: Constants.countriesDropDownItems,
                                    value: searchCountry,
                                    onChanged: (value) {
                                      searchCountry = value!;

                                      cityListDisplay = _applyFilter(
                                        cityListDisplay,
                                        cityList,
                                        searchCityName,
                                        searchCountry,
                                      );
                                      setState(() {});
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.flag),
                        )
                        //   DropdownButton(
                        //     items: Constants.countriesDropDownItems,
                        //     value: searchCountry,
                        //     onChanged: (value) {
                        //       searchCountry = value!;

                        //       cityListDisplay = _applyFilter(
                        //         cityListDisplay,
                        //         cityList,
                        //         searchCityName,
                        //         searchCountry,
                        //       );
                        //       setState(() {});
                        //     },
                        //   ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: cityListDisplay.length + 1,
                      itemBuilder: (context, index) {
                        if (index == cityListDisplay.length) {
                          return const SizedBox(height: 90);
                        }

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
                      onPressed: () {
                        // be sure about removing all saved cities
                        showDialog(
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
                        // update saved cities
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

  // select city or unselect it
  void _selectCity(String city) {
    if (savedCitiesDisplay.contains(city)) {
      savedCitiesDisplay.remove(city);
    } else {
      savedCitiesDisplay.add(city);
    }

    setState(() {});
  }
}

// apply filters based in searchValue
List<List<String>> _applyFilter(List<List<String>> cityListDisplay,
    List<List<String>> cityList, String searchCityName, String searchCountry) {
  searchCityName = searchCityName.toLowerCase();

  String cityName;
  String countryName;
  return cityListDisplay = cityList.where((value) {
    cityName = value[0].toLowerCase();
    countryName = value[1].toLowerCase();
    return cityName.contains(searchCityName) &&
        countryName.contains(searchCountry);
  }).toList();
}
