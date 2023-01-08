import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_check/main.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String permissionDenied = "";
  dynamic data;


  @override
  void initState() {
    super.initState();
    checkPermissionStatus();
  }



  void checkPermissionStatus() async {
    bool status = await Permission.location.serviceStatus.isEnabled;
    getData();
  }

  void getData() async
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => MainScreen(permissionDenied , weatherData: response,)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(FontAwesomeIcons.cloudSunRain, color: Colors.white, size: 50),
            SizedBox(height: 20),
            Text(
              'Weather Check',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
