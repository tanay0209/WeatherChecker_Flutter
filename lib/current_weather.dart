import 'package:flutter/material.dart';

TextStyle cityDetails = const TextStyle(fontSize: 16, color: Colors.white);

Widget cityTemperature(
    String iconUrl, String temperature, String weather, String city) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(iconUrl),
        Column(
          children: [
            Text(temperature, style: const TextStyle(fontSize: 32 , color: Colors.white)),
            const SizedBox(height: 10),
            Text(weather, style: cityDetails),
            const SizedBox(height: 10),
            Text(city, style: const TextStyle(fontSize: 24 , color: Colors.white))
          ],
        )
      ],
    ),
  );
}
