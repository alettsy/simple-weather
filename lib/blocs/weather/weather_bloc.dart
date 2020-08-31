import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/weather_model.dart';
import '../../resources/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// A BLoC to handle weather events and states.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  /// Set the initial state to the selected day index of zero.
  WeatherBloc() : super(WeatherInitial(0));

  /// Map weather [event] to states.
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherData) {
      yield* _mapGetWeatherToState();
    } else if (event is SelectDay) {
      yield* _mapSelectDayToState(event);
    } else if (event is UpdateWeather) {
      yield* _mapUpdateWeatherToState();
    }
  }

  /// Display a circular progress indicator while getting weather data,
  /// then show the weather page if successful, otherwise display the error.
  Stream<WeatherState> _mapGetWeatherToState() async* {
    try {
      yield GettingWeatherData();
      final data = await getWeather();
      yield WeatherDataSuccess(data, 0);
      startTimer();
    } on Exception {
      yield GettingWeatherFailed();
    }
  }

  /// Update which day is selected in the [event] and yield that day's weather.
  Stream<WeatherState> _mapSelectDayToState(SelectDay event) async* {
    if (state is WeatherDataSuccess) {
      final weathers = (state as WeatherDataSuccess).weathers;
      yield WeatherDataSuccess(weathers, event.selected);
    }
  }

  /// Update the weather without showing the progress indicator to 'quietly'
  /// do it in the background while the user is using the app.
  Stream<WeatherState> _mapUpdateWeatherToState() async* {
    if (state is WeatherDataSuccess) {
      try {
        final sw = Stopwatch()..start();
        final data = await getWeather();
        sw.stop();
        print('time for getting weather update: ${sw.elapsed}');
        yield WeatherDataSuccess(
            data, (state as WeatherDataSuccess).selectedIndex);
        startTimer();
      } on Exception {
        yield GettingWeatherFailed();
      }
    }
  }

  /// Get the current weather and create the weather objects, and get the
  /// city name.
  Future<List<Weather>> getWeather() async {
    final weathers = <Weather>[];

    final weatherData = await WeatherRepo().getWeatherJson();
    final city = await WeatherRepo().getCity();

    final daily = weatherData['daily'];

    final current = weatherData['current'];
    weathers.add(Weather.currentWeather(
        current, daily[0]['temp']['max'], daily[0]['temp']['min'], city));

    for (var i = 1; i < daily.length; i++) {
      final weather = Weather.fromJson(daily[i], city);
      weathers.add(weather);
    }

    return weathers;
  }

  /// An update timer which updates weather data every 2 minutes.
  void startTimer() async {
    Timer(Duration(seconds: 180), () {
      add(
        UpdateWeather(
          (state as WeatherDataSuccess).selectedIndex,
        ),
      );
    });
  }
}
