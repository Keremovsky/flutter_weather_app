// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Weather {
  int temp;
  String state;
  int pressure;
  int humidity;
  double speed;

  Weather({
    required this.temp,
    required this.state,
    required this.pressure,
    required this.humidity,
    required this.speed,
  });

  Weather copyWith({
    int? temp,
    String? state,
    int? pressure,
    int? humidity,
    double? speed,
  }) {
    return Weather(
      temp: temp ?? this.temp,
      state: state ?? this.state,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      speed: speed ?? this.speed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
      'state': state,
      'pressure': pressure,
      'humidity': humidity,
      'speed': speed,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      temp: map['temp'] as int,
      state: map['state'] as String,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
      speed: map['speed'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Weather(temp: $temp, state: $state, pressure: $pressure, humidity: $humidity, speed: $speed)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.temp == temp &&
        other.state == state &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.speed == speed;
  }

  @override
  int get hashCode {
    return temp.hashCode ^
        state.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        speed.hashCode;
  }
}
