import 'package:intl/intl.dart';

class Weather {
  final String updated;
  final String date;
  final String city;
  final String weatherState;
  final String weatherStateDescription;
  final int weatherId;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final int humidity;

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

extension UnitConversion on double {
  double toCelcius() {
    return this - 273.15;
  }
}
