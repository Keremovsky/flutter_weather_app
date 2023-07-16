import 'package:flutter/material.dart';

class SavedCityWeatherBox extends StatelessWidget {
  const SavedCityWeatherBox({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud,
                      size: height * 0.06,
                    ),
                    SizedBox(width: height * 0.02),
                    Text(
                      "Saved City",
                      style: TextStyle(
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Temp",
                  style: TextStyle(
                    fontSize: height * 0.02,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
