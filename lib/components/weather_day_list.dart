import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather/weather_bloc.dart';
import '../components/weather_day.dart';
import '../models/weather_model.dart';
import '../resources/resources.dart';

class WeatherDayList extends StatelessWidget {
  final List<Weather> weathers;
  final int selectedIndex;

  const WeatherDayList({
    Key key,
    @required this.weathers,
    @required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: ListView.builder(
        itemCount: weathers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final imageUrl = getWeatherStyle(weathers[index].weatherId)[0];
          return GestureDetector(
            onTap: () {
              context.bloc<WeatherBloc>().add(SelectDay(index));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: WeatherDay(
                  icon: Image.asset(imageUrl, scale: 16),
                  weather: weathers[index],
                  selected: index == selectedIndex,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
