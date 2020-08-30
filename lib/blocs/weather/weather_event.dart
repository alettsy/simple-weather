part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherDataEvent extends WeatherEvent {}

class SelectDay extends WeatherEvent {
  final int selected;

  SelectDay(this.selected);
}
