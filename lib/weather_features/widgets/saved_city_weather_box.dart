import 'package:flutter/material.dart';

class SavedCityWeatherBox extends StatelessWidget {
  const SavedCityWeatherBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.5),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud,
                      size: 45,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "Saved City",
                      style: TextStyle(
                        fontSize: 22.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Temp",
                  style: TextStyle(
                    fontSize: 15,
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
