import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/weather/controller/weather_controller.dart';
import 'package:flutter_weather_app/features/weather/widgets/location_weather_box.dart';
import '../../../models/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationWeatherScreen extends ConsumerStatefulWidget {
  static const routeName = "/locationWeatherScreen";

  const LocationWeatherScreen({super.key});

  @override
  ConsumerState<LocationWeatherScreen> createState() =>
      _LocationWeatherScreenState();
}

class _LocationWeatherScreenState extends ConsumerState<LocationWeatherScreen> {
  final formKey = GlobalKey<FormState>();

  late String lat;
  late String lng;

  Weather weather = Weather(
    temp: 0,
    state: "wait",
    pressure: 0,
    humidity: 0,
    speed: 0,
    lat: 0,
    lng: 0,
  );

  Future<Weather> getWeatherWithLocation(double lat, double lng) async {
    final result = await ref
        .read(weatherControllerProvider.notifier)
        .getWeatherWithLocation(context, lat, lng);

    return result;
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
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
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
            LocationWeatherBox(weather: weather),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  weather = await getWeatherWithLocation(
                      double.parse(lat), double.parse(lng));
                  setState(() {});
                }
              },
              child: const Text("Get Weather"),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
