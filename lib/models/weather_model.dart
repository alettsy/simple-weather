import 'package:intl/intl.dart';

class Weather {
  final String updated;
  final String date;
  final String weatherState;
  final String weatherStateAbbr;
  final String windDirection;
  final double windSpeed;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final int humidity;

  Weather({
    this.updated,
    this.date,
    this.weatherState,
    this.weatherStateAbbr,
    this.windDirection,
    this.windSpeed,
    this.minTemp,
    this.maxTemp,
    this.currentTemp,
    this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      updated: DateFormat('kk:mm').format(DateTime.now()),
      date: DateFormat('EEEE', 'en_US')
          .format(DateTime.parse(json['applicable_date'])),
      weatherState: json['weather_state_name'],
      weatherStateAbbr: json['weather_state_abbr'],
      windDirection: json['wind_direction_compass'],
      windSpeed: json['wind_speed'],
      minTemp: json['min_temp'],
      maxTemp: json['max_temp'],
      currentTemp: json['the_temp'],
      humidity: json['humidity'],
    );
  }
}
