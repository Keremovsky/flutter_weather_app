// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UnitSetting {
  final String tempUnit;
  final String pressureUnit;
  final String windSpeedUnit;
  final int timeFormatUnit;

  UnitSetting({
    required this.tempUnit,
    required this.pressureUnit,
    required this.windSpeedUnit,
    required this.timeFormatUnit,
  });

  UnitSetting copyWith({
    String? tempUnit,
    String? pressureUnit,
    String? windSpeedUnit,
    int? timeFormatUnit,
  }) {
    return UnitSetting(
      tempUnit: tempUnit ?? this.tempUnit,
      pressureUnit: pressureUnit ?? this.pressureUnit,
      windSpeedUnit: windSpeedUnit ?? this.windSpeedUnit,
      timeFormatUnit: timeFormatUnit ?? this.timeFormatUnit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tempUnit': tempUnit,
      'pressureUnit': pressureUnit,
      'windSpeedUnit': windSpeedUnit,
      'timeFormatUnit': timeFormatUnit,
    };
  }

  factory UnitSetting.fromMap(Map<String, dynamic> map) {
    return UnitSetting(
      tempUnit: map['tempUnit'] as String,
      pressureUnit: map['pressureUnit'] as String,
      windSpeedUnit: map['windSpeedUnit'] as String,
      timeFormatUnit: map['timeFormatUnit'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitSetting.fromJson(String source) =>
      UnitSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UnitSetting(tempUnit: $tempUnit, pressureUnit: $pressureUnit, windSpeedUnit: $windSpeedUnit, timeFormatUnit: $timeFormatUnit)';
  }

  @override
  bool operator ==(covariant UnitSetting other) {
    if (identical(this, other)) return true;

    return other.tempUnit == tempUnit &&
        other.pressureUnit == pressureUnit &&
        other.windSpeedUnit == windSpeedUnit &&
        other.timeFormatUnit == timeFormatUnit;
  }

  @override
  int get hashCode {
    return tempUnit.hashCode ^
        pressureUnit.hashCode ^
        windSpeedUnit.hashCode ^
        timeFormatUnit.hashCode;
  }
}
