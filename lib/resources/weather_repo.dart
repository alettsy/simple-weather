import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../constants.dart';
import 'dart:convert';

class WeatherRepo {
  // get location
  Future<bool> checkLocationPermissions() async {
    //final status = await Geolocator().checkGeolocationPermissionStatus();

    // TODO: return true only if granted
    return true;
  }

  Future<String> getCity() async {
    if (await checkLocationPermissions()) {
      final position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);

      final place = placemark[0];
      print(place.locality);
      return place.locality;
    }

    return 'none';
  }

  // get woeied
  Future<String> getWoeid() async {
    final city = await getCity();
    final response = await http.get('$woiedUrl$city');

    if (response.body.length > 3 && response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data[0]['woeid']);
      return data[0]['woeid'].toString();
    } else {
      print('failed in woeid');
      return '00000';
    }
  }

  // get weather data
  Future<Map<String, dynamic>> getWeatherJson() async {
    final woeid = await getWoeid();

    final response = await http.get('$weatherUrl$woeid');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('got the json from server');
      return data;
    } else {
      print('failed to get json from server');
      return <String, dynamic>{};
    }
  }
}
