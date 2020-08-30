import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherDay extends StatelessWidget {
  final Image icon;
  final bool selected;
  final Weather weather;

  const WeatherDay({
    Key key,
    @required this.weather,
    @required this.icon,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? Colors.white : null,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Text('${weather.date.substring(0, 3)}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('${weather.maxTemp.toStringAsFixed(0)}°C',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
