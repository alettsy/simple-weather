import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/weather/weather_bloc.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather',
      home: HomeScreen(),
    );
  }
}
