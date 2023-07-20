import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/weather/screens/update_saved_city_screen.dart';
import 'package:flutter_weather_app/features/weather/screens/weather_home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const WeatherHomeScreen(),
        UpdateSavedCityScreen.routeName: (context) =>
            const UpdateSavedCityScreen(),
      },
    );
  }
}
