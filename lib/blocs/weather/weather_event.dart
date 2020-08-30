part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherDataEvent extends WeatherEvent {}
