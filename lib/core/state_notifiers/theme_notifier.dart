import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/widgets/end_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
    (ref) => ThemeNotifier(ref));

class ThemeNotifier extends StateNotifier<ThemeMode> {
  SharedPreferences? prefs;
  Ref ref;

  ThemeNotifier(this.ref) : super(ThemeMode.dark) {
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    int theme = await prefs?.getInt("theme") ?? state.index;

    if (theme == 1) ref.read(switchProvider.notifier).update((state) => true);

    state = ThemeMode.values[theme];
  }

  void setTheme(ThemeMode mode) {
    state = mode;
    prefs!.setInt("theme", state.index);
  }
}
