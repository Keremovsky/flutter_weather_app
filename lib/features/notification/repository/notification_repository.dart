import 'dart:convert';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_weather_app/core/constants/api_keys.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final notificationRepositoryProvider =
    Provider((ref) => NotificationRepository());

class NotificationRepository {
  final _plugin = FlutterLocalNotificationsPlugin();
  late SharedPreferences _prefs;

  NotificationRepository() {
    init();
  }

  Future init() async {
    // initialize local notifications
    const androidSettings = AndroidInitializationSettings("mipmap/ic_launcher");
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );
    await _plugin.initialize(initializationSettings);

    // initialize android alarm manager
    await AndroidAlarmManager.initialize();

    // initialize shared preferences
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String> setScheduleNotification(
      String cityName, Duration repeat, int hour) async {
    try {
      // get permission from user to send notifications
      final permission = await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();

      if (permission ?? false) {
        // if there is a notification for given city, return without creating notification
        List<String> notificationCities =
            _prefs.getStringList("notificationCities") ?? [];
        for (final city in notificationCities) {
          if (city == cityName) {
            return "already_has_city";
          }
        }

        // get unique id for android alarm manager and notification
        final id = cityName.hashCode;
        final dateNow = DateTime.now();

        final result = await AndroidAlarmManager.periodic(
          repeat,
          id,
          _backgroundTask,
          startAt: DateTime(
            dateNow.year,
            dateNow.month,
            dateNow.day,
            hour,
          ),
          exact: true,
          rescheduleOnReboot: true,
          params: {
            "cityName": cityName,
            "apiKey": openWeatherApiKey,
          },
        );

        if (!result) {
          return "android_alarm_false";
        }

        // save city name
        notificationCities.add(cityName);
        _prefs.setStringList("notificationCities", notificationCities);

        return "success";

        // await _plugin.zonedSchedule(
        //   0,
        //   "title",
        //   "body",
        //   tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        //   notificationDetails,
        //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        //   uiLocalNotificationDateInterpretation:
        //       UILocalNotificationDateInterpretation.absoluteTime,
        // );
      } else {
        return "no_permission";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> removeScheduleNotification(String cityName) async {
    try {
      final id = cityName.hashCode;

      final result = await AndroidAlarmManager.cancel(id);
      if (!result) {
        return "android_alarm_false";
      }
      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}

@pragma('vm:entry-point')
void _backgroundTask(int alarmId, Map<String, dynamic> argument) async {
  String cityName = argument["cityName"];
  final apiKey = argument["apiKey"];

  // control if phone has internet connection
  final connection = await InternetConnectionChecker().hasConnection;
  if (connection) {
    // if city is current city
    if (cityName == "Current City") {
      final result = await http.get(Uri.parse("http://ip-api.com/json"));
      final data = jsonDecode(result.body);

      cityName = data["regionName"];
    }

    // get weather data from open weather
    final result = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,&APPID=$apiKey"),
    );
    final data = jsonDecode(result.body);

    // if there is an error, return without doing anything
    if (data["cod"] != "200") {
      return;
    }

    // get together data for city weather
    final dataList = data["list"];

    final country = data["city"]["country"];

    final parseHour = DateTime.parse(dataList[0]["dt_txt"]);

    final temp = dataList[0]["main"]["temp"].toInt();
    final state = dataList[0]["weather"][0]["main"];
    final pressure = dataList[0]["main"]["pressure"];
    final humidity = dataList[0]["main"]["humidity"];
    final speed = dataList[0]["wind"]["speed"];
    final hour = DateFormat.Hm().format(parseHour);

    CityWeather cityWeather = CityWeather(
      cityName: cityName,
      country: country,
      temp: temp,
      state: state,
      pressure: pressure,
      humidity: humidity,
      speed: speed,
      hour: hour,
    );

    // set notification details
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'chanel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // send notification
    await FlutterLocalNotificationsPlugin().show(
      alarmId,
      cityName,
      "${cityWeather.temp}⁰K",
      notificationDetails,
    );
  }
}