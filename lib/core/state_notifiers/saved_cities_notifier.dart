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

  // get saved cities from phone when initialize state notifier
  void init() async {
    prefs = await SharedPreferences.getInstance();
    final savedCities = prefs.getStringList("savedCities") ?? [];

    state = savedCities;
  }

  // change saved cities
  void setSavedCities(List<String> newCities) {
    prefs.setStringList("savedCities", newCities);
    final savedCities = prefs.getStringList("savedCities") ?? [];

    state = savedCities;
  }
}
