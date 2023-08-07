import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final notificationStateNotifierProvider =
    StateNotifierProvider<NotificationCitiesNotifier, List<String>>(
        (ref) => NotificationCitiesNotifier());

class NotificationCitiesNotifier extends StateNotifier<List<String>> {
  late SharedPreferences prefs;

  NotificationCitiesNotifier() : super([]) {
    init();
  }

  // get notification cities from phone when initialize state notifier
  void init() async {
    prefs = await SharedPreferences.getInstance();
    final notificationCities = prefs.getStringList("notificationCities") ?? [];

    state = notificationCities;
  }

  // change notification cities
  void setNotificatinCity(List<String> newCities) {
    prefs.setStringList("notificationCities", newCities);
    final notificationCities = prefs.getStringList("notificationCities") ?? [];

    state = notificationCities;
  }
}
