import 'package:flutter/material.dart';

List<dynamic> getWeatherStyle(int weatherId) {
  String image;
  Color color1;
  Color color2;

  switch (weatherId.toString()) {
    case '511':
      image = 'assets/icons/hail.png';
      color1 = Colors.blue[50];
      color2 = Colors.blue[200];
      break;
    case '611':
    case '612':
    case '613':
    case '615':
    case '616':
    case '620':
    case '621':
    case '622':
      image = 'assets/icons/sleet.png';
      color1 = Colors.blue[50];
      color2 = Colors.blue[200];
      break;
    case '600':
    case '601':
    case '602':
      image = 'assets/icons/snow.png';
      color1 = Colors.white;
      color2 = Colors.grey[500];
      break;
    case '200':
    case '201':
    case '202':
    case '210':
    case '211':
    case '212':
    case '221':
    case '230':
    case '231':
    case '232':
      image = 'assets/icons/stormy.png';
      color1 = Colors.grey[800];
      color2 = Colors.grey[900];
      break;
    case '502':
    case '503':
    case '504':
    case '522':
    case '531':
    case '302':
    case '312':
    case '314':
      image = 'assets/icons/heavy-rain.png';
      color1 = Colors.blueGrey[600];
      color2 = Colors.blueGrey[800];
      break;
    case '500':
    case '501':
    case '520':
    case '521':
    case '300':
    case '301':
    case '310':
    case '311':
    case '313':
    case '321':
      image = 'assets/icons/light-rain.png';
      color1 = Colors.blue[800];
      color2 = Colors.blue[900];
      break;
    case '803':
    case '804':
      image = 'assets/icons/heavy-cloud.png';
      color1 = Colors.grey;
      color2 = Colors.grey[700];
      break;
    case '801':
    case '802':
      image = 'assets/icons/light-cloud.png';
      color1 = Colors.grey[300];
      color2 = Colors.grey;
      break;
    case '701':
    case '711':
    case '721':
    case '731':
    case '741':
    case '751':
    case '761':
    case '762':
    case '771':
    case '781':
      image = 'assets/icons/haze.png';
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
