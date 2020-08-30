import 'package:flutter/material.dart';

class LoadingWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
