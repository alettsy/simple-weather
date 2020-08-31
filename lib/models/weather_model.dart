import 'package:intl/intl.dart';
import 'unit_conversion.dart';

/// A Weather object.
///
/// Contains basic weather information such as humidity and temperature.
class Weather {
  /// The last time the weather was updated.
  final String updated;

  /// The date the weather is for.
  final String date;

  /// The city the weather is for.
  final String city;

  /// The current weather state. Example: Cloudy.
  final String weatherState;

  /// Description of the weather state. Example: Staggered Clouds.
  final String weatherStateDescription;

  /// The weather state as an interger ID.
  final int weatherId;

  /// The minimum temperature for the day.
  final double minTemp;

  /// The maximum temperature for the day.
  final double maxTemp;

  /// The current temperature.
  final double currentTemp;

  /// The humidity for the day (or current humidity).
  final int humidity;

  /// Create the weather object where all parameters are optional.
  Weather({
    this.updated,
    this.date,
    this.city,
    this.weatherState,
    this.weatherStateDescription,
    this.weatherId,
    this.minTemp,
    this.maxTemp,
    this.currentTemp,
    this.humidity,
  });

  /// Create a Weather object from [json] and a [city] string.
  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    final dateFromEpoch =
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);

    return Weather(
      updated: DateFormat('kk:mm').format(DateTime.now()),
      date: DateFormat('EEEE', 'en_US')
          .format(DateTime.parse(dateFromEpoch.toString())),
      city: city,
      weatherState: json['weather'][0]['main'],
      weatherStateDescription: json['weather'][0]['description'],
      weatherId: json['weather'][0]['id'],
      minTemp: forceDouble(json['temp']['min']).toCelcius(),
      maxTemp: forceDouble(json['temp']['max']).toCelcius(),
      currentTemp: forceDouble(json['temp']['day']).toCelcius(),
      humidity: json['humidity'],
    );
  }

  /// Create a Weather object from [json] with separate [maxTemp], [minTemp],
  /// and [city] parameters.
  factory Weather.currentWeather(
      Map<String, dynamic> json, double maxTemp, double minTemp, String city) {
    final dateFromEpoch =
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);

    return Weather(
      updated: DateFormat('kk:mm').format(DateTime.now()),
      date: DateFormat('EEEE').format(DateTime.parse(dateFromEpoch.toString())),
      city: city,
      weatherState: json['weather'][0]['main'],
      weatherStateDescription: json['weather'][0]['description'],
      weatherId: json['weather'][0]['id'],
      minTemp: minTemp.toCelcius(),
      maxTemp: maxTemp.toCelcius(),
      currentTemp: forceDouble(json['temp']).toCelcius(),
      humidity: json['humidity'],
    );
  }

  /// Force a [value] to be a double if possible.
  ///
  /// Converts an integer or dynamic value, where possible, to be a double.
  static double forceDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return double.tryParse(value);
    }
  }
}
