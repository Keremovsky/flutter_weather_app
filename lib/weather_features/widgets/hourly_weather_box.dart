import 'package:flutter/material.dart';

class HourlyWeatherBox extends StatelessWidget {
  const HourlyWeatherBox({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Card(
      child: SizedBox(
        height: height * 0.14,
        width: height * 0.14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Hour",
              style: TextStyle(fontSize: height * 0.02),
            ),
            Icon(
              Icons.cloud,
              size: height * 0.06,
            ),
            Text(
              "Temp",
              style: TextStyle(fontSize: height * 0.02),
            ),
          ],
        ),
      ),
    );
  }
}
