import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../components/forecast_title.dart';
import '../models/constant.dart';
import '../models/city.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../components/second_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Constant myColor = Constant();
  List<String> selectedCitiesName =
      City.getSelectedCities().map((city) => city.name).toList();
  String cityName = 'Jakarta';
  String currentDate = 'Loading..';
  String mainCondition = '';
  String description = '';

  num temp = 0;
  num windSpeed = 0;
  num humidity = 0;
  num clouds = 0;
  List<String> citiesName = [];
  List<Weather> _weathers = [];

  void _fetchForecast() async {
    WeatherService ws = WeatherService();
    try {
      _weathers = await ws.getForecast(cityName);
      Weather w = _weathers.first;
      DateTime myDate = DateTime.parse(w.date);
      currentDate = DateFormat('EEEE, d MMMM').format(myDate);
      setState(() {
        mainCondition = w.mainCondition;
        description = w.description;
        temp = w.temperature;
        windSpeed = w.windSpeed;
        humidity = w.humidity;
        clouds = w.clouds;
      });
    } catch (e) {
      print('error = $e');
    }
  }

  void citiesList() {
    citiesName.add(cityName);
    for (var cityName in selectedCitiesName) {
      citiesName.add(cityName);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchForecast();
    citiesList();
  }

  void selectedCity(String newValue) {
    setState(() {
      cityName = newValue;
      _fetchForecast();
    });
  }

  String getWeatherAnimation(String mainCondition) {
    switch (mainCondition) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: myColor.homeColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: titleAppbar(),
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  currentDate,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(height: size.height * 0.07),

                // Display a main informations about the weather
                weatherDisplay(size),
                SizedBox(height: size.height * 0.04),

                // sub informations belom the main Display
                SecondDisplay(
                  windSpeed: windSpeed,
                  humidity: humidity,
                  clouds: clouds,
                  firstColor: Colors.grey[600],
                  secondColor: Colors.blue[400],
                  style: true,
                  space: 0,
                ),

                SizedBox(height: size.height * 0.03),

                // just a title for weather Next 5 Days
                ForecastTitle(),

                SizedBox(height: size.height * 0.01),

                // a list of weathers for next 5 days
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _weathers.length,
                    itemBuilder: (context, index) {
                      Weather weatherData = _weathers[index];
                      DateTime dateData = DateTime.parse(weatherData.date);
                      String theDate = DateFormat('EEE').format(dateData);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: {
                              'weathers': _weathers,
                              'selectedId': index,
                              'cityName': cityName,
                            },
                          );
                          print(index);
                          // print('hmm');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 15, bottom: 5, top: 5),
                          width: size.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (theDate == currentDate.substring(0, 3))
                                ? myColor.primaryColor
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                                color: Colors.black54.withOpacity(.2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${weatherData.temperature.toInt()}C',
                                style: TextStyle(
                                  color:
                                      (theDate == currentDate.substring(0, 3))
                                          ? Colors.white
                                          : myColor.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Lottie.asset(
                                getWeatherAnimation(
                                    weatherData.mainCondition.toLowerCase()),
                                width: 40,
                              ),
                              Text(
                                theDate,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      (theDate == currentDate.substring(0, 3))
                                          ? Colors.white
                                          : myColor.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Center weatherDisplay(Size size) {
    return Center(
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.25,
        decoration: BoxDecoration(
          color: myColor.primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100,
              offset: const Offset(0, 25),
              blurRadius: 10,
              spreadRadius: -10,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -50,
              left: 5,
              child: Lottie.asset(
                  getWeatherAnimation(mainCondition.toLowerCase()),
                  width: 150),
            ),
            Positioned(
              bottom: 18,
              left: 22,
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Text(
                '${temp.toInt()}°',
                style: TextStyle(
                  color: Colors.blue[100],
                  fontSize: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row titleAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Weather App',
        ),
        Row(
          children: [
            Icon(
              Icons.location_pin,
              color: myColor.primaryColor,
            ),
            const SizedBox(width: 3),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: cityName,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                items:
                    citiesName.map<DropdownMenuItem<String>>((String cityName) {
                  return DropdownMenuItem<String>(
                    value: cityName,
                    child: Text(cityName),
                    onTap: () => selectedCity(cityName),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
