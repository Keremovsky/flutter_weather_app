import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/common/alert_dialog_title.dart';
import 'package:flutter_weather_app/core/constants/constants.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';
import '../../../models/unit_setting.dart';

class UnitSettings extends ConsumerStatefulWidget {
  const UnitSettings({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UnitSettingsState();
}

class _UnitSettingsState extends ConsumerState<UnitSettings> {
  // variable to hold unit setting
  late UnitSetting unitSetting;

  // unit values
  late String tempUnit;
  late String pressureUnit;
  late String windSpeedUnit;
  late String timeFormatUnit;

  @override
  void initState() {
    super.initState();

    // get unit setting
    UnitSetting initUnitSetting = ref.read(unitSettingNotifierProvider);

    // give initial values to unit values
    tempUnit = initUnitSetting.tempUnit;
    pressureUnit = initUnitSetting.pressureUnit;
    windSpeedUnit = initUnitSetting.windSpeedUnit;
    timeFormatUnit = initUnitSetting.timeFormatUnit;
  }

  @override
  Widget build(BuildContext context) {
    unitSetting = ref.watch(unitSettingNotifierProvider);

    return AlertDialog(
      content: SizedBox(
        height: 320,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const AlertDialogTitle(text: "Unit Settings"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Temperature",
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton(
                  items: Constants.tempDropDownItems,
                  value: tempUnit,
                  onChanged: (value) {
                    setState(() {
                      tempUnit = value!;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Pressure",
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton(
                  items: Constants.pressureDropDownItems,
                  value: pressureUnit,
                  onChanged: (value) {
                    setState(() {
                      pressureUnit = value!;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Wind Speed",
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton(
                  items: Constants.windDropDownItems,
                  value: windSpeedUnit,
                  onChanged: (value) {
                    setState(() {
                      windSpeedUnit = value!;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Time Format",
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton(
                  items: Constants.timeDropDownItems,
                  value: timeFormatUnit,
                  onChanged: (value) {
                    setState(() {
                      timeFormatUnit = value!;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // update unit settings
                    ref
                        .read(unitSettingNotifierProvider.notifier)
                        .setUnitSetting(
                          unitSetting.copyWith(
                            tempUnit: tempUnit,
                            pressureUnit: pressureUnit,
                            windSpeedUnit: windSpeedUnit,
                            timeFormatUnit: timeFormatUnit,
                          ),
                        );

                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
