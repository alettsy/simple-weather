import 'package:flutter/material.dart';

List<dynamic> getWeatherStyle(String weatherAbbr) {
  String image;
  Color color1;
  Color color2;

  switch (weatherAbbr) {
    case 'h':
      image = 'assets/icons/hail.png';
      color1 = Colors.blue[50];
      color2 = Colors.blue[200];
      break;
    case 'sl':
      image = 'assets/icons/sleet.png';
      color1 = Colors.blue[50];
      color2 = Colors.blue[200];
      break;
    case 'sn':
      image = 'assets/icons/snow.png';
      color1 = Colors.white;
      color2 = Colors.grey[500];
      break;
    case 't':
      image = 'assets/icons/stormy.png';
      color1 = Colors.grey[800];
      color2 = Colors.grey[900];
      break;
    case 'hr':
      image = 'assets/icons/heavy-rain.png';
      color1 = Colors.blueGrey[600];
      color2 = Colors.blueGrey[800];
      break;
    case 'lr':
      image = 'assets/icons/light-rain.png';
      color1 = Colors.blue[800];
      color2 = Colors.blue[900];
      break;
    case 'hc':
      image = 'assets/icons/heavy-cloud.png';
      color1 = Colors.grey;
      color2 = Colors.grey[700];
      break;
    case 'lc':
      image = 'assets/icons/light-cloud.png';
      color1 = Colors.grey[300];
      color2 = Colors.grey;
      break;
    default:
      image = 'assets/icons/sun.png';
      color1 = Colors.yellow[100];
      color2 = Colors.yellow[300];
  }

  return [image, color1, color2];
}
