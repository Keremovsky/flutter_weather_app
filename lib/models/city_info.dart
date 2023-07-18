// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CityWeather {
  String cityName;
  double temp;
  String state;
  int pressure;
  int humidity;
  double speed;

  CityWeather({
    required this.cityName,
    required this.temp,
    required this.state,
    required this.pressure,
    required this.humidity,
    required this.speed,
  });

  CityWeather copyWith({
    String? cityName,
    double? temp,
    String? state,
    int? pressure,
    int? humidity,
    double? speed,
  }) {
    return CityWeather(
      cityName: cityName ?? this.cityName,
      temp: temp ?? this.temp,
      state: state ?? this.state,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      speed: speed ?? this.speed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityName': cityName,
      'temp': temp,
      'state': state,
      'pressure': pressure,
      'humidity': humidity,
      'speed': speed,
    };
  }

  factory CityWeather.fromMap(Map<String, dynamic> map) {
    return CityWeather(
      cityName: map['cityName'] as String,
      temp: map['temp'] as double,
      state: map['state'] as String,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
      speed: map['speed'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityWeather.fromJson(String source) =>
      CityWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CityWeather(cityName: $cityName, temp: $temp, state: $state, pressure: $pressure, humidity: $humidity, speed: $speed)';
  }

  @override
  bool operator ==(covariant CityWeather other) {
    if (identical(this, other)) return true;

    return other.cityName == cityName &&
        other.temp == temp &&
        other.state == state &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.speed == speed;
  }

  @override
  int get hashCode {
    return cityName.hashCode ^
        temp.hashCode ^
        state.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        speed.hashCode;
  }
}
