import 'package:flutter/material.dart';
import 'splashScreen.dart';

void main()
{
  runApp(const WeatherCheck());
}
class WeatherCheck extends StatelessWidget {
  const WeatherCheck({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Weather Check',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



