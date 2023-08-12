import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_weather_app/features/weather/controller/weather_controller.dart';
import 'package:flutter_weather_app/features/weather/widgets/location_weather_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/weather/widgets/location_weather_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/weather.dart';

class LocationWeatherScreen extends ConsumerStatefulWidget {
  static const routeName = "/locationWeatherScreen";

  const LocationWeatherScreen({super.key});

  @override
  ConsumerState<LocationWeatherScreen> createState() =>
      _LocationWeatherScreenState();
}

class _LocationWeatherScreenState extends ConsumerState<LocationWeatherScreen> {
  // form key to get input from user
  late GlobalKey<FormState> formKey;

  // controller for map
  late MapController mapController;

  // coordinates
  late String lat;
  late String lng;

  // initial value for weather
  Weather weather = Weather(
    cityName: "",
    temp: 0,
    state: "wait",
    pressure: 0,
    humidity: 0,
    speed: 0,
    lat: 41.7353512,
    lng: 27.2232678,
  );

  // get weather data based on coordinates
  Future<Weather> getWeatherWithLocation(double lat, double lng) async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getWeatherWithLocation(context, lat, lng);

    return result;
  }

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Weather"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            LocationWeatherMap(weather: weather, mapController: mapController),
            const SizedBox(height: 20),
            LocationWeatherBox(weather: weather),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.39,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Fill text field!";
                          } else {
                            final d = double.tryParse(value);
                            if (d == null) {
                              return "Input must be double!";
                            }
                          }
                        },
                        onSaved: (value) => lat = value!,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "latitude",
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.map,
                      size: 30,
                    ),
                    SizedBox(
                      width: width * 0.39,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Fill text field!";
                          } else {
                            final d = double.tryParse(value);
                            if (d == null) {
                              return "Input must be double!";
                            }
                          }
                        },
                        onSaved: (value) => lng = value!,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "longitude",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        weather = await getWeatherWithLocation(
                          double.parse(lat),
                          double.parse(lng),
                        );

                        mapController.move(
                          LatLng(weather.lat, weather.lng),
                          12,
                        );

                        setState(() {});
                      }
                    },
                    child: const Text("Get Weather"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
