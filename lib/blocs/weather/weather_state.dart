part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {
  final int selectedIndex;

  WeatherInitial(this.selectedIndex);
}

class GettingWeatherData extends WeatherState {}

class WeatherDataSuccess extends WeatherState {
  final int selectedIndex;
  final String locationName;
  final List<Weather> weathers;

  WeatherDataSuccess(this.locationName, this.weathers, this.selectedIndex);
}

class GettingWeatherFailed extends WeatherState {}
