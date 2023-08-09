// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// help to store weather data of a city (for getting weather based on saved cities and current city)
class CityWeather {
  String cityName;
  String country;
  int temp;
  String state;
  int pressure;
  int humidity;
  num windSpeed;
  String hour;

  CityWeather({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.state,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.hour,
  });

  CityWeather copyWith({
    String? cityName,
    String? country,
    int? temp,
    String? state,
    int? pressure,
    int? humidity,
    double? speed,
    String? hour,
  }) {
    return CityWeather(
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      temp: temp ?? this.temp,
      state: state ?? this.state,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      windSpeed: speed ?? this.windSpeed,
      hour: hour ?? this.hour,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityName': cityName,
      'country': country,
      'temp': temp,
      'state': state,
      'pressure': pressure,
      'humidity': humidity,
      'speed': windSpeed,
      'hour': hour,
    };
  }

  factory CityWeather.fromMap(Map<String, dynamic> map) {
    return CityWeather(
      cityName: map['cityName'] as String,
      country: map['country'] as String,
      temp: map['temp'] as int,
      state: map['state'] as String,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
      windSpeed: map['speed'] as double,
      hour: map['hour'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityWeather.fromJson(String source) =>
      CityWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CityWeather(cityName: $cityName, country: $country, temp: $temp, state: $state, pressure: $pressure, humidity: $humidity, speed: $windSpeed, hour: $hour)';
  }

  @override
  bool operator ==(covariant CityWeather other) {
    if (identical(this, other)) return true;

    return other.cityName == cityName &&
        other.country == country &&
        other.temp == temp &&
        other.state == state &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.windSpeed == windSpeed &&
        other.hour == hour;
  }

  @override
  int get hashCode {
    return cityName.hashCode ^
        country.hashCode ^
        temp.hashCode ^
        state.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        windSpeed.hashCode ^
        hour.hashCode;
  }
}
