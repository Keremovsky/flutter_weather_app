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
  final cityNames = Constants.cities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cityNames.length,
                  itemBuilder: (context, index) {
                    final list = ref.read(selectedCities);
                    bool isSelected = list.contains(cityNames[index]);

                    return CityTile(
                      city: cityNames[index],
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
