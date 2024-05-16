import 'package:flutter/material.dart';

class SecondDisplay extends StatelessWidget {
  const SecondDisplay(
      {super.key,
      required this.windSpeed,
      required this.humidity,
      required this.clouds,
      this.firstColor,
      required this.secondColor,
      required this.style,
      required this.space});

  final num windSpeed;
  final num humidity;
  final num clouds;
  final Color? firstColor;
  final Color? secondColor;
  final bool style;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            style
                ? Text(
                    'Wind Speed',
                    style: TextStyle(
                      color: firstColor,
                      fontSize: 14,
                    ),
                  )
                : const SizedBox(),
            SizedBox(height: space),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                style ? 'assets/windy.gif' : 'assets/wind.png',
                width: 45,
              ),
            ),
            SizedBox(height: space),
            Text(
              '${windSpeed.toInt()}m/s',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: secondColor,
                fontSize: 14,
              ),
            )
          ],
        ),
        Column(
          children: [
            style
                ? Text(
                    'Humidity',
                    style: TextStyle(
                      color: firstColor,
                      fontSize: 14,
                    ),
                  )
                : const SizedBox(),
            SizedBox(height: space),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                style ? 'assets/humidity.gif' : 'assets/humidity.png',
                width: 45,
              ),
            ),
            SizedBox(height: space),
            Text(
              '$humidity%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: secondColor,
                fontSize: 14,
              ),
            )
          ],
        ),
        Column(
          children: [
            style
                ? Text(
                    'Clouds',
                    style: TextStyle(
                      color: firstColor,
                      fontSize: 14,
                    ),
                  )
                : const SizedBox(),
            SizedBox(height: space),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                style ? 'assets/clouds.gif' : 'assets/clouds.png',
                width: 45,
              ),
            ),
            SizedBox(height: space),
            Text(
              '$clouds%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: secondColor,
                fontSize: 14,
              ),
            )
          ],
        ),
      ],
    );
  }
}
