import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class ApplicationData {
  // Current City
  dynamic currentCityWeather() async {
    Position position = await Geolocator.getCurrentPosition();
    final queryParameter = {
      'lat': (position.latitude).toStringAsFixed(2),
      'lon': (position.longitude).toStringAsFixed(2),
      'appid': '292a6ddcb97926b600c6d2e9d9dccef3'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameter);
    final response = await http.get(uri);
  }

  //Given Location
  dynamic searchCityWeather(String cityName) async
  {
    final queryParameter = {
      'q': cityName,
      'appid': '292a6ddcb97926b600c6d2e9d9dccef3'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameter);
    final response = await http.get(uri);
    var weatherData = jsonDecode(response.body);
    return weatherData;
  }


  //get Location
  dynamic getPositionDetails() async
  {
    Position position = await Geolocator.getCurrentPosition();
    final queryParameter = {
      'lat': (position.latitude).toStringAsFixed(2),
      'lon': (position.longitude).toStringAsFixed(2),
      'appid': '292a6ddcb97926b600c6d2e9d9dccef3'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameter);
    final response = await http.get(uri);
    var weatherData = jsonDecode(response.body);
    return weatherData;
  }

  // Location Permission Status
  dynamic permissionStatus() async
  {
    var status = Permission.location.serviceStatus;
    if (await status.isEnabled) {
      return true;
    }
    else {
      await Permission.location.request();
    }
  }
}
