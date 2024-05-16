class Weather {
  final String cityName;
  final String mainCondition;
  final String description;
  final num temperature;
  final String date;
  final num windSpeed;
  final num humidity;
  final num clouds;

  Weather({
    required this.cityName,
    required this.mainCondition,
    required this.description,
    required this.temperature,
    required this.date,
    required this.windSpeed,
    required this.humidity,
    required this.clouds,
  });

  factory Weather.fromJson(String city, var json) {
    return Weather(
      cityName: city,
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      date: json['dt_txt'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
      clouds: json['clouds']['all'],
    );
  }
}
