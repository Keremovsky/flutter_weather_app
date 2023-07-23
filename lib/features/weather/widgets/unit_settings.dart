import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/core/state_notifiers/unit_setting_notifer.dart';

class UnitSettings extends ConsumerWidget {
  final double radius = 10;

  const UnitSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitSetting = ref.watch(unitSettingNotifierProvider);

    return AlertDialog(
      content: Column(
        children: [
          const Text(
            "Unit Settings",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Temperature: ${unitSetting.tempUnit}",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Wind Speed: ${unitSetting.windSpeedUnit}",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Pressure: ${unitSetting.pressureUnit}",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Time Format: ${unitSetting.timeFormatUnit}",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
