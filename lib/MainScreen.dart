import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_check/ApplLogic.dart';
import 'package:weather_check/widget.dart';
import 'current_weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
  ApplicationData object = ApplicationData();

class _MainScreenState extends State<MainScreen> {
  String temperature = '',
      cityName = '--',
      pressure = '--',
      humidity = '--',
      feelsLike = '--',
      windSpeed = '--',
      minTemp = '--',
      maxTemp = '--',
      weather = '--',
      iconUrl = 'https://openweathermap.org/img/wn/01d@2x.png',
      errorText = '',
      hintText = 'Enter a city name';


  @override
  void initState(){
    super.initState();
    getWeatherDetails();
  }

  void getWeatherDetails() async
  {
    var cityWeatherDetails = await object.getPositionDetails();
    setValues(cityWeatherDetails);
  }

  void setValues(dynamic weatherDetails)
  {
    var data = weatherDetails;
    if(data['cod'] == '404')
    {
      setState(() {
        errorText='Enter a valid city name';
      });
    }
    else
    {
      setState(() {
        errorText='';
      });
    }
    if(data['cod'] !='404') {
      var main = data['main'];
      var wind = data['wind'];
      var weatherType = data['weather'];
      var weatherDetail = weatherType[0];
      String iconCode = weatherDetail['icon'];
      String generatedIconUrl(String iconCode) {
        return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
      }
      setState(() {
        temperature = (main['temp'] - 273).toStringAsFixed(2) + '°C';
        minTemp = (main['temp_min'] - 273).toStringAsFixed(2) + '°C';
        maxTemp = (main['temp_max'] - 273).toStringAsFixed(2) + '°C';
        cityName = data['name'];
        humidity = "${main['humidity']}%";
        pressure = '${main['pressure']} atm';
        feelsLike = (main['temp_max'] - 273).toStringAsFixed(2) + '°C';
        windSpeed = "${wind['speed']} km/hr";
        weather = weatherDetail['main'];
        iconUrl = generatedIconUrl(iconCode);
        cityController.text = data['name'];
      });
    }
  }

  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 2,
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: cityController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: hintText,
                          contentPadding: const EdgeInsets.all(4),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: OutlinedButton(
                          onPressed: () => object.currentCityWeather(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            backgroundColor: Colors.black38,
                          ),
                          child: const Text(
                            'Current City',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () async => {
                          FocusScope.of(context).unfocus(),
                            setValues(await object.searchCityWeather(cityController.text)),
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Search',
                            style: TextStyle(color: Colors.black,
                                fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text(errorText ,
                    style: TextStyle(
                      color: Colors.red.shade300,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,

                    )),
                const SizedBox(height: 15),
                cityTemperature(iconUrl, temperature, weather, cityName),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoBox(
                        'Min Temp.', FontAwesomeIcons.temperatureLow, minTemp),
                    infoBox(
                        'Max Temp.', FontAwesomeIcons.temperatureHigh, maxTemp),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoBox('Pressure', FontAwesomeIcons.gauge, pressure),
                    infoBox('Humidity', Icons.water_drop, humidity),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoBox('Feels Like', FontAwesomeIcons.temperatureFull,
                        feelsLike),
                    infoBox('Wind', FontAwesomeIcons.wind, windSpeed),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

