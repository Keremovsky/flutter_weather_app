import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/constants.dart';
import 'package:flutter_weather_app/features/weather/widgets/city_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  final cityList = Constants.cities;
  List<String> cityListDisplay = Constants.cities;
  List<String> savedCitiesPref = [];

  String searchValue = "";
  final TextEditingController citySearchController = TextEditingController();

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: citySearchController,
                  decoration: const InputDecoration(
                    hintText: "Search",
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchValue = value;
                      cityListDisplay =
                          _applyFilter(cityListDisplay, cityList, searchValue);
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cityListDisplay.length,
                  itemBuilder: (context, index) {
                    bool isSelected = list.contains(cityListDisplay[index]);

                    return CityTile(
                      city: cityListDisplay[index],
                      selectCity: _selectCity,
                      isSelected: isSelected,
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setStringList("savedCities", savedCitiesPref);

                  if (mounted) Navigator.of(context).pop();
                },
                child: const Text("Update Selected Cities"),
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

List<String> _applyFilter(
    List<String> cityListDisplay, List<String> cityList, String searchValue) {
  searchValue = searchValue.toLowerCase();

  return cityListDisplay = cityList.where((value) {
    value = value.toLowerCase();
    return value.contains(searchValue);
  }).toList();
}
