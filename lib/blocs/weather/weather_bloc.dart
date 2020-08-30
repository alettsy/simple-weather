import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/weather_model.dart';
import '../../resources/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherDataEvent) {
      yield* _mapGetWeatherToState();
    }
  }

  Stream<WeatherState> _mapGetWeatherToState() async* {
    final weathers = <Weather>[];

    try {
      yield GettingWeatherData();
      final city = await WeatherRepo().getCity();
      final data = await getWeather();
      yield WeatherDataSuccess(city, data);
    } on Exception {
      yield GettingWeatherFailed();
    }
  }

  Future<List<Weather>> getWeather() async {
    final weathers = <Weather>[];

    final weatherData = await WeatherRepo().getWeatherJson();

    final oneOnly = Weather.fromJson(weatherData['consolidated_weather'][0]);
    weathers.add(oneOnly);

    return weathers;
  }
}
