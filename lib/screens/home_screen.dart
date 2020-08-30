import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/blocs/weather/weather_bloc.dart';
import 'package:simple_weather/models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget showWeather(String location, List<Weather> weathers) {
    final weatherStyle = getWeatherStyle(weathers[0].weatherStateAbbr);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      color: weatherStyle[1] as Color,
      padding: EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                location,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Text(
              'Updated 16:38',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 80),
            Column(
              children: [
                weatherStyle[0],
                const SizedBox(height: 30),
                tempAndHumidity(weathers[0]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget weatherType(String weatherState, List<dynamic> weatherStyle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weatherState,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Image(image: weatherStyle[0] as AssetImage),
      ],
    );
  }

  List<dynamic> getWeatherStyle(String weatherAbbr) {
    Image image;
    Color color;

    switch (weatherAbbr) {
      case 'sn':
      case 'sl':
      case 'hl':
        image = Image.asset('assets/icons/snowing.png', scale: 0.8);
        color = Colors.white;
        break;
      case 't':
        image = Image.asset('assets/icons/storm.png', scale: 0.8);
        color = Colors.grey[800];
        break;
      case 'hr':
        image = Image.asset('assets/icons/raining.png', scale: 0.8);
        color = Colors.blueGrey[600];
        break;
      case 'lr':
        image = Image.asset('assets/icons/raining.png', scale: 0.8);
        color = Colors.blue[800];
        break;
      case 'hc':
        image = Image.asset('assets/icons/cloudy.png', scale: 0.8);
        color = Colors.grey;
        break;
      case 'lc':
        image = Image.asset('assets/icons/partly-cloudy.png', scale: 0.8);
        color = Colors.grey[300];
        break;
      default:
        image = Image.asset('assets/icons/sunny.png', scale: 5);
        color = Colors.white;
    }

    return [image, color];
  }

  Widget tempAndHumidity(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${weather.currentTemp.toStringAsFixed(0)}°C',
          style: TextStyle(fontSize: 64),
        ),
        const SizedBox(height: 10),
        Text(
          '${weather.maxTemp.toStringAsFixed(0)}°C / ${weather.minTemp.toStringAsFixed(0)}°C',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget loadingWeather() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(height: 20),
          Text('Loading Weather'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<WeatherBloc>().add(GetWeatherDataEvent());

    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is GettingWeatherData) {
            return loadingWeather();
          } else if (state is GettingWeatherFailed) {
            return Text('failed to get weather');
          } else if (state is WeatherDataSuccess) {
            return showWeather(state.locationName, state.weathers);
          }

          return Container();
        },
      ),
    );
  }
}
