import 'package:flutter/material.dart';
import 'package:flutter_weather_app/pages/detail_page.dart';
import 'pages/choose_locations.dart';
import 'pages/home_page.dart';
import 'pages/welcome_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/chooseLocations': (context) => const ChooseLocations(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}
