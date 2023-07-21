import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/weather.dart';

class LocationWeatherScreen extends StatefulWidget {
  static const routeName = "/locationWeatherScreen";

  const LocationWeatherScreen({super.key});

  @override
  State<LocationWeatherScreen> createState() => _LocationWeatherScreenState();
}

class _LocationWeatherScreenState extends State<LocationWeatherScreen> {
  Weather weather = Weather(
    temp: 0,
    state: "wait",
    pressure: 0,
    humidity: 0,
    speed: 0,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.39,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "latitude"),
                    ),
                  ),
                  const Icon(
                    Icons.map,
                    size: 30,
                  ),
                  SizedBox(
                    width: width * 0.39,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "longitude"),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Get Weather"),
            ),
            SizedBox(
              height: 195,
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 25,
                      sigmaY: 25,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Constants.weatherIcons[weather.state],
                                    size: 52.5,
                                  ),
                                  Text(weather.state),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.water_drop,
                                    size: 52.5,
                                  ),
                                  Text("${weather.humidity}%"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.air,
                                    size: 52.5,
                                  ),
                                  Text("${weather.speed} m/s"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.beach_access,
                                    size: 52.5,
                                  ),
                                  Text("${weather.pressure} hPa"),
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
          ],
        ),
      ),
    );
  }
}
