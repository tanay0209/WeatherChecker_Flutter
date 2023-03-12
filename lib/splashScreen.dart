import 'package:permission_handler/permission_handler.dart';
import 'package:weather_check/main.dart';
import 'ApplLogic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  ApplicationData obj = ApplicationData();
  late dynamic status ;
  @override
  void initState(){
    super.initState();
    checkStatus();
  }
  void checkStatus() async
  {
    var status = Permission.location.serviceStatus;
    if (await status.isEnabled) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    }
    else {
      await Permission.location.request();
      checkStatus();
    }
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
