import 'dart:convert';
import 'package:flutter_weather_app/core/state_notifiers/notification_cities_notifier.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import 'package:flutter_weather_app/models/city_weather.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_weather_app/core/constants/api_keys.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

final notificationRepositoryProvider =
    Provider((ref) => NotificationRepository(ref: ref));

class NotificationRepository {
  final _plugin = FlutterLocalNotificationsPlugin();
  final Ref _ref;

  NotificationRepository({required Ref ref}) : _ref = ref {
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
  }

  Future<String> setScheduleNotification(
      String cityName, Duration repeat, int hour, int minutes) async {
    try {
      // get permission from user to send notifications
      final permission = await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();

      if (permission ?? false) {
        // get created notification cities
        List<String> notificationCities =
            _ref.read(notificationStateNotifierProvider);

        // get unique id for android alarm manager and notification
        final id = cityName.hashCode;
        final dateNow = DateTime.now();

        // get unit settings
        final unitSetting = _ref.read(unitSettingNotifierProvider);

        // create background task for notifications
        final result = await AndroidAlarmManager.periodic(
          repeat,
          id,
          _backgroundTask,
          startAt: DateTime(
            dateNow.year,
            dateNow.month,
            dateNow.day,
            hour,
            minutes,
          ),
          exact: true,
          rescheduleOnReboot: true,
          params: {
            "cityName": cityName,
            "tempUnit": unitSetting.tempUnit,
            "apiKey": openWeatherApiKey,
          },
        );

        // if result is false, return android_alarm_false error
        if (!result) {
          return "android_alarm_false";
        }

        // save city name
        if (!notificationCities.contains(cityName)) {
          notificationCities.add(cityName);
        }
        _ref
            .read(notificationStateNotifierProvider.notifier)
            .setNotificationCity(notificationCities);

        return "success";

        // code for scheduled notifications
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
        // if user didn't give permission for notifications
        return "no_permission";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> removeScheduleNotification(List<String> cities) async {
    try {
      // cancel all notifications for given cities
      for (final city in cities) {
        final id = city.hashCode;
        await AndroidAlarmManager.cancel(id);
      }

      // get remaining cities after given cities canceled
      List<String> holdCities = [];
      final notificationCities = _ref.read(notificationStateNotifierProvider);
      for (final city in notificationCities) {
        if (!cities.contains(city)) {
          holdCities.add(city);
        }
      }

      // overwrite cities
      _ref
          .read(notificationStateNotifierProvider.notifier)
          .setNotificationCity(holdCities);

      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}

@pragma('vm:entry-point')
void _backgroundTask(int alarmId, Map<String, dynamic> argument) async {
  // get city name, api key and temp unit
  String cityName = argument["cityName"];
  final apiKey = argument["apiKey"];
  final tempUnit = argument["tempUnit"];

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

    // get data together for city weather
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
      windSpeed: speed,
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

    // modify weather data based on unit setting
    final cityTemp =
        tempUnit == "C" ? (cityWeather.temp - 273) : cityWeather.temp;

    // send notification
    await FlutterLocalNotificationsPlugin().show(
      alarmId,
      cityName,
      "$cityTemp⁰$tempUnit",
      notificationDetails,
    );
  }
}
