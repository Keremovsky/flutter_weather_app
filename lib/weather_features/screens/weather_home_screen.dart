import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/weather_features/widgets/hourly_weather_box.dart';
import 'package:flutter_weather_app/weather_features/widgets/saved_city_weather_box.dart';

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // main city weather
            SizedBox(
              height: 195,
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
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "City Name",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.menu,
                                  size: 30,
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
                                    size: 52.5,
                                  ),
                                  Text("Cloudy"),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: 52.5,
                                  ),
                                  Text("Cloudy"),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: 52.5,
                                  ),
                                  Text("Cloudy"),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: 52.5,
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
              padding: EdgeInsets.all(15),
              child: SizedBox(
                height: 112.5,
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
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 275,
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
                        fontSize: 27.5,
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
