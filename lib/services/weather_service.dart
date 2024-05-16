import 'dart:convert';

import 'package:flutter_weather_app/models/weather.dart';
import 'package:http/http.dart';

class WeatherService {
  static const String baseUrl =
      'http://api.openweathermap.org/data/2.5/forecast';
  static const String apiKey = 'f58ba2fd36ad8a1e7d10f0fa8da0a17f';

  Future<List<Weather>> getForecast(String cityName) async {
    Response response =
        await get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      List<Weather> dummy = [];
      List<Weather> forecast = [];
      var data = jsonDecode(response.body);
      for (var weather in data['list']) {
        dummy.add(Weather.fromJson(cityName, weather));
      }
      for (var i = 0; i < dummy.length; i += 8) {
        forecast.add(dummy[i]);
      }
      // print('forecast: $forecast');
      return forecast;
    } else {
      throw Exception('Something wrong: ${response.statusCode}');
    }
  }
}
