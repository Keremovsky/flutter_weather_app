import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/weather_features/widgets/hourly_weather_box.dart';
import 'package:flutter_weather_app/weather_features/widgets/saved_city_weather_box.dart';

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // main city weather
            SizedBox(
              height: height * 0.26,
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 25,
                      sigmaY: 25,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "City Name",
                                style: TextStyle(
                                  fontSize: height * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.menu,
                                  size: height * 0.04,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: height * 0.07,
                                  ),
                                  Text("Cloudy"),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: height * 0.07,
                                  ),
                                  Text("Cloudy"),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: height * 0.07,
                                  ),
                                  Text("Cloudy"),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: height * 0.07,
                                  ),
                                  Text("Cloudy"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // hourly weather list
            Padding(
              padding: EdgeInsets.all(height * 0.02),
              child: SizedBox(
                height: height * 0.15,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    HourlyWeatherBox(),
                    HourlyWeatherBox(),
                    HourlyWeatherBox(),
                    HourlyWeatherBox(),
                    HourlyWeatherBox(),
                    HourlyWeatherBox(),
                  ],
                ),
              ),
            ),
            const Divider(),
            // saved cities
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Saved Cities",
                    style: TextStyle(
                      fontSize: height * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.02),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.35,
                    child: ListView(
                      children: [
                        SavedCityWeatherBox(),
                        SavedCityWeatherBox(),
                        SavedCityWeatherBox(),
                        SavedCityWeatherBox(),
                        SavedCityWeatherBox(),
                        SavedCityWeatherBox(),
                        SavedCityWeatherBox(),
                        SavedCityWeatherBox(),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Add new city",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
