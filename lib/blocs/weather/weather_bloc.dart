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
      final city = await WeatherRepo().getCity();
      final data = await getWeather();
      yield WeatherDataSuccess(city, data, 0);
      startTimer();
    } on Exception {
      yield GettingWeatherFailed();
    }
  }

  Stream<WeatherState> _mapSelectDayToState(SelectDay event) async* {
    if (state is WeatherDataSuccess) {
      final location = (state as WeatherDataSuccess).locationName;
      final weathers = (state as WeatherDataSuccess).weathers;
      yield WeatherDataSuccess(location, weathers, event.selected);
    }
  }

  Stream<WeatherState> _mapUpdateWeatherToState(UpdateWeather event) async* {
    if (state is WeatherDataSuccess) {
      try {
        final city = await WeatherRepo().getCity();
        final data = await getWeather();
        yield WeatherDataSuccess(
            city, data, (state as WeatherDataSuccess).selectedIndex);
      } on Exception {
        yield GettingWeatherFailed();
      }
    }
  }

  Future<List<Weather>> getWeather() async {
    final weathers = <Weather>[];

    final weatherData = await WeatherRepo().getWeatherJson();

    final consolidated = weatherData['consolidated_weather'] as List<dynamic>;
    for (var i = 0; i < consolidated.length; i++) {
      final weather = Weather.fromJson(consolidated[i]);
      weathers.add(weather);
    }

    return weathers;
  }

  void startTimer() async {
    timer = Timer(Duration(minutes: 1), () {
      add(
        UpdateWeather(
          (state as WeatherDataSuccess).selectedIndex,
        ),
      );
    });
  }
}