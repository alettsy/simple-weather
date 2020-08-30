import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import '../constants.dart';

class WeatherRepo {
  Future<bool> checkLocationPermissions() async {
    final status = await Geolocator().checkGeolocationPermissionStatus();

    if (status != GeolocationStatus.granted) {
      throw Exception('Location permissions not enabled.');
    } else {
      return true;
    }
  }

  Future<Position> getCoords() async {
    await checkLocationPermissions();

    try {
      final position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);

      return position;
    } on Exception {
      print('Failed to get Coordinates');
      rethrow;
    }
  }

  // get weather data
  Future<Map<String, dynamic>> getWeatherJson() async {
    try {
      final position = await getCoords();
      final url =
          '${weatherUrl}lat=${position.latitude}&lon=${position.longitude}$weatherKey';
      final response = await http.get(url).timeout(Duration(seconds: 10));

      print('url: $url');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received Weather JSON');
        return data;
      }
    } on Exception {
      print('Failed to get Weather JSON');
      rethrow;
    }
  }

  Future<String> getCity() async {
    try {
      final position = await getCoords();
      var coords = Coordinates(position.latitude, position.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coords);
      for (var i = 0; i < addresses.length; i++) {
        final locality = addresses[i].locality;
        if (locality != null) {
          return locality;
        }
      }
      return 'none';
    } on Exception {
      print('Failed to get City');
      rethrow;
    }
  }
}
