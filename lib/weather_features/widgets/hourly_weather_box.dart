import 'package:flutter/material.dart';

class HourlyWeatherBox extends StatelessWidget {
  const HourlyWeatherBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 105,
        width: 105,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Hour",
              style: TextStyle(fontSize: 15),
            ),
            Icon(
              Icons.cloud,
              size: 45,
            ),
            Text(
              "Temp",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
