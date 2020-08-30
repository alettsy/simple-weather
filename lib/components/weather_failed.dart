import 'package:flutter/material.dart';

class WeatherFailed extends StatelessWidget {
  const WeatherFailed({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 18, color: Colors.black),
              children: [
                TextSpan(
                    text: 'Failed to get weather data!\n',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Please make sure you are connected to'),
                TextSpan(text: ' the internet '),
                TextSpan(
                    text: 'and', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' that you have enabled location permissions'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
