import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:geocoder/geocoder.dart';

class WeatherRepo {
  Future<bool> checkLocationPermissions() async {
    //final status = await Geolocator().checkGeolocationPermissionStatus();

    // TODO: return true only if granted
    return true;
  }

  Future<Position> getCoords() async {
    if (await checkLocationPermissions()) {
      final position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);

      return position;
    }

    return Position();
  }

  // get weather data
  Future<Map<String, dynamic>> getWeatherJson() async {
    final position = await getCoords();

    final url =
        '${weatherUrl}lat=${position.latitude}&lon=${position.longitude}$weatherKey';

    try {
      final response = await http.get(url);

      print('url: $url');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received Weather JSON');
        return data;
      } else {
        print('Error getting Weather JSON');
        return <String, dynamic>{};
      }
    } on Exception {
      print('Failed to get Weather JSON');
      rethrow;
    }
  }

  Future<String> getCity() async {
    final position = await getCoords();
    var coords = Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coords);
    for (var i = 0; i < addresses.length; i++) {
      final locality = addresses[i].locality;
      if (locality != null) {
        return locality;
      }
    }

    return 'Unkown Location';
  }
}
