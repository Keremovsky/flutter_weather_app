import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/constants.dart';
import 'package:flutter_weather_app/features/weather/widgets/city_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/weather/widgets/delete_saved_cities_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

final savedCitiesProvider = StateProvider((ref) => []);

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
  List<String> savedCitiesPref = [];

  String searchValue = "";

  Future<void> getSavedCitiesPref() async {
    prefs.then((value) {
      savedCitiesPref = value.getStringList("savedCities")!;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    getSavedCitiesPref();
  }

  @override
  Widget build(BuildContext context) {
    final list = savedCitiesPref;
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

                        if (mounted) Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.delete_forever,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setStringList("savedCities", savedCitiesPref);

                        if (mounted) Navigator.of(context).pop();
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
    if (savedCitiesPref.contains(city)) {
      savedCitiesPref.remove(city);
    } else {
      savedCitiesPref.add(city);
    }

    debugPrint("select $city");
    debugPrint(savedCitiesPref.toString());

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
