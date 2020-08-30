part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherData extends WeatherEvent {}

class SelectDay extends WeatherEvent {
  final int selected;

  SelectDay(this.selected);
}

class UpdateWeather extends WeatherEvent {
  final int selectedIndex;

  UpdateWeather(this.selectedIndex);
}
