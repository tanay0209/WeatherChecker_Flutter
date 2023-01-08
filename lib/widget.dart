import 'package:flutter/material.dart';


TextStyle infoTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);


Widget infoBox(String title, IconData infoIcon, String information) {
  return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(infoIcon, size: 50),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: infoTextStyle,
          ),
          const SizedBox(height: 10),
          Text(
            information,
            style:  infoTextStyle,
              textAlign: TextAlign.center
          ),
        ],
      ));
}


