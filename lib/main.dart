import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/state_notifiers/theme_notifier.dart';
import 'package:flutter_weather_app/features/notification/screens/notifications_screen.dart';
import 'package:flutter_weather_app/features/notification/screens/remove_notification_screen.dart';
import 'package:flutter_weather_app/features/weather/screens/location_weather_screen.dart';
import 'package:flutter_weather_app/features/notification/screens/create_notification_screen.dart';
import 'package:flutter_weather_app/features/weather/screens/update_saved_city_screen.dart';
import 'package:flutter_weather_app/features/weather/screens/weather_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const WeatherHomeScreen(),
        UpdateSavedCityScreen.routeName: (context) =>
            const UpdateSavedCityScreen(),
        LocationWeatherScreen.routeName: (context) =>
            const LocationWeatherScreen(),
        NotificationsScreen.routeName: (context) => const NotificationsScreen(),
        CreateNotificationScreen.routeName: (context) =>
            const CreateNotificationScreen(),
        RemoveNotificationScreen.routeName: (context) =>
            const RemoveNotificationScreen(),
      },
    );
  }
}
