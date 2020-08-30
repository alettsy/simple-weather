import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/weather_model.dart';
import '../../resources/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  Timer timer;

  WeatherBloc() : super(WeatherInitial(0));

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherData) {
      yield* _mapGetWeatherToState();
    } else if (event is SelectDay) {
      yield* _mapSelectDayToState(event);
    } else if (event is UpdateWeather) {
      yield* _mapUpdateWeatherToState(event);
    }
  }

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

  Stream<WeatherState> _mapSelectDayToState(SelectDay event) async* {
    if (state is WeatherDataSuccess) {
      final weathers = (state as WeatherDataSuccess).weathers;
      yield WeatherDataSuccess(weathers, event.selected);
    }
  }

  Stream<WeatherState> _mapUpdateWeatherToState(UpdateWeather event) async* {
    if (state is WeatherDataSuccess) {
      try {
        final data = await getWeather();
        yield WeatherDataSuccess(
            data, (state as WeatherDataSuccess).selectedIndex);
      } on Exception {
        yield GettingWeatherFailed();
      }
    }
  }

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

  void startTimer() async {
    timer = Timer(Duration(minutes: 2), () {
      add(
        UpdateWeather(
          (state as WeatherDataSuccess).selectedIndex,
        ),
      );
    });
  }
}
