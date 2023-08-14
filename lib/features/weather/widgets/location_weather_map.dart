import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_weather_app/models/weather.dart';
import 'package:latlong2/latlong.dart';

class LocationWeatherMap extends StatefulWidget {
  final Weather weather;
  final MapController mapController;

  const LocationWeatherMap({
    required this.weather,
    required this.mapController,
    super.key,
  });

  @override
  State<LocationWeatherMap> createState() => _LocationWeatherMapState();
}

class _LocationWeatherMapState extends State<LocationWeatherMap> {
  // variable to hold zoom value for map
  double mapZoom = 12;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.weather.lat, widget.weather.lng),
          zoom: mapZoom,
        ),
        mapController: widget.mapController,
        nonRotatedChildren: [
          Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(),
              ),
            ],
          )
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(widget.weather.lat, widget.weather.lng),
                builder: (context) {
                  return const Icon(
                    Icons.place,
                    color: Colors.black,
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
