import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather/weather_bloc.dart';
import '../components/components.dart';
import '../models/weather_model.dart';
import '../resources/weather_style.dart';

/// The main screen to display the weather data.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Build the weather page with the [selected] weather as well as the
  /// days which are made from [weathers].
  Widget showWeather(int selected, List<Weather> weathers) {
    final weatherStyle = getWeatherStyle(weathers[selected].weatherId);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [weatherStyle[1] as Color, (weatherStyle[2] as Color)],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      padding: EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                weathers[0].city,
                style: TextStyle(fontSize: 32),
              ),
            ),
            Text(
              'Updated ${weathers[selected].updated}',
            ),
            const SizedBox(height: 60),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                children: [
                  Image.asset(weatherStyle[0] as String, scale: 3),
                  const SizedBox(height: 30),
                  Temperature(weather: weathers[selected]),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            WeatherDayList(
              weathers: weathers,
              selectedIndex: selected,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<WeatherBloc>().add(GetWeatherData());

    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is GettingWeatherData) {
            return LoadingWeather();
          } else if (state is GettingWeatherFailed) {
            return WeatherFailed();
          } else if (state is WeatherDataSuccess) {
            return showWeather(state.selectedIndex, state.weathers);
          }

          return Container();
        },
      ),
    );
  }
}
