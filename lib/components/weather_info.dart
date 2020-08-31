import 'package:flutter/material.dart';
import '../models/weather_model.dart';

/// Show the weather information broken down contained within [weather].
class WeatherInfo extends StatelessWidget {
  final Weather weather;

  const WeatherInfo({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${weather.currentTemp.toStringAsFixed(0)}°C',
          style: TextStyle(fontSize: 64),
        ),
        const SizedBox(height: 10),
        Text(
          '${weather.weatherStateDescription.toLowerCase()}',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          '${weather.maxTemp.toStringAsFixed(0)}°C / ${weather.minTemp.toStringAsFixed(0)}°C',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
