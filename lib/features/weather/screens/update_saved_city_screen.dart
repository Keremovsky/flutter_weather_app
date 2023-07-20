import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/constants.dart';
import 'package:flutter_weather_app/features/weather/widgets/city_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCities = StateProvider((ref) => <String>[]);

class UpdateSavedCityScreen extends ConsumerStatefulWidget {
  static const routeName = "/createSavedCityScreen";

  const UpdateSavedCityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddSavedCityScreenState();
}

class _AddSavedCityScreenState extends ConsumerState<UpdateSavedCityScreen> {
  final cityList = Constants.cities;
  List<String> cityListDisplay = Constants.cities;
  String searchValue = "";
  final TextEditingController citySearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final list = ref.read(selectedCities);
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
                onPressed: () {
                  Navigator.of(context).pop();
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
    final list = ref.read(selectedCities);

    if (list.contains(city)) {
      list.remove(city);
    } else {
      list.add(city);
    }

    ref.read(selectedCities.notifier).update((state) => list);
    debugPrint("selectCity");

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
