import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final savedCitiesNotifierProvider =
    StateNotifierProvider<SavedCitiesNotifier, List<String>>(
        (ref) => SavedCitiesNotifier());

class SavedCitiesNotifier extends StateNotifier<List<String>> {
  late SharedPreferences prefs;

  SavedCitiesNotifier() : super([]) {
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    final savedCities = prefs.getStringList("savedCities") ?? [];

    state = savedCities;
  }

  void setSavedCities(List<String> newCities) {
    prefs.setStringList("savedCities", newCities);
    final savedCities = prefs.getStringList("savedCities") ?? [];

    state = savedCities;
  }
}
