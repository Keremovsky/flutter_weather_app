import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/models/unit_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

final unitSettingNotifierProvider =
    StateNotifierProvider((ref) => UnitSettingNotifer());

class UnitSettingNotifer extends StateNotifier<UnitSetting> {
  late SharedPreferences prefs;

  UnitSettingNotifer()
      : super(
          UnitSetting(
              tempUnit: "C",
              pressureUnit: "hPa",
              windSpeedUnit: "m/s",
              timeFormatUnit: "24"),
        );

  void init() async {
    prefs = await SharedPreferences.getInstance();
    final List<String> unitSettingValues =
        prefs.getStringList("unitSetting") ?? ["C", "hPa", "m/s", "24"];

    final unitSetting = UnitSetting(
      tempUnit: unitSettingValues[0],
      pressureUnit: unitSettingValues[1],
      windSpeedUnit: unitSettingValues[2],
      timeFormatUnit: unitSettingValues[3],
    );

    state = unitSetting.copyWith();
  }

  void setUnitSetting(UnitSetting newUnitSetting) {
    List<String> unitSettingValues = [
      newUnitSetting.tempUnit,
      newUnitSetting.pressureUnit,
      newUnitSetting.windSpeedUnit,
      newUnitSetting.timeFormatUnit,
    ];
    prefs.setStringList("unitSetting", unitSettingValues);

    state = newUnitSetting.copyWith();
  }
}
