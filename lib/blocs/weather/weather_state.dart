part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class GettingWeatherData extends WeatherState {}

class WeatherDataSuccess extends WeatherState {
  final String locationName;
  final List<Weather> weathers;

  WeatherDataSuccess(this.locationName, this.weathers);
}

class GettingWeatherFailed extends WeatherState {}
