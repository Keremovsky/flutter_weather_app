// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// help to store weather data (for getting weather based on coordinates)
class Weather {
  String cityName;
  int temp;
  String state;
  int pressure;
  int humidity;
  double speed;
  double lat;
  double lng;

  Weather({
    required this.cityName,
    required this.temp,
    required this.state,
    required this.pressure,
    required this.humidity,
    required this.speed,
    required this.lat,
    required this.lng,
  });

  Weather copyWith({
    String? name,
    int? temp,
    String? state,
    int? pressure,
    int? humidity,
    double? speed,
    double? lat,
    double? lng,
  }) {
    return Weather(
      cityName: name ?? this.cityName,
      temp: temp ?? this.temp,
      state: state ?? this.state,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      speed: speed ?? this.speed,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': cityName,
      'temp': temp,
      'state': state,
      'pressure': pressure,
      'humidity': humidity,
      'speed': speed,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      cityName: map['name'] as String,
      temp: map['temp'] as int,
      state: map['state'] as String,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
      speed: map['speed'] as double,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Weather(name: $cityName, temp: $temp, state: $state, pressure: $pressure, humidity: $humidity, speed: $speed, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.cityName == cityName &&
        other.temp == temp &&
        other.state == state &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.speed == speed &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return cityName.hashCode ^
        temp.hashCode ^
        state.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        speed.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}
