import 'package:flutter/material.dart';
import 'package:flutter_weather_app/components/second_display.dart';
import 'package:flutter_weather_app/models/constant.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Constant myColor = Constant();
  dynamic data = {};

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
    data = ModalRoute.of(context)?.settings.arguments;
    var detailWeathers = data['weathers'];
    String location = data['cityName'];
    var selectedWeather = detailWeathers[data['selectedId']];
    Size size = MediaQuery.of(context).size;
    // DateTime myDate = DateTime.parse(selectedWeather.date);
    // String theday = DateFormat('EEEE, MMMM d').format(myDate);

    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          location,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/chooseLocations', (route) => false),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.blue[200],
                    height: size.height,
                    width: size.width,
                  ),
                  Positioned(
                    bottom: 50,
                    child: Container(
                      height: size.height * 0.6,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: size.height * 0.2,
                    child: Container(
                      height: size.height * 0.6,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [
                            Colors.blue.shade100,
                            Colors.blue.shade300,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.2),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Lottie.asset(
                            getWeatherAnimation(
                                selectedWeather.mainCondition.toLowerCase()),
                            height: 180,
                          ),
                          Text(
                            '${selectedWeather.temperature.toInt()}°',
                            style: TextStyle(
                              color: Colors.blue[100],
                              fontSize: 50,
                            ),
                          ),
                          // Text(
                          //   theday,
                          //   style: const TextStyle(
                          //     color: Colors.white54,
                          //   ),
                          // ),
                          Text(
                            selectedWeather.description,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(
                              color: Colors.blue[200],
                            ),
                          ),
                          SecondDisplay(
                            windSpeed: selectedWeather.windSpeed,
                            humidity: selectedWeather.humidity,
                            clouds: selectedWeather.clouds,
                            secondColor: Colors.white60,
                            style: false,
                            space: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    var weatherData = data['weathers'][index];
                    DateTime dateData = DateTime.parse(weatherData.date);
                    String theDate = DateFormat('EEE').format(dateData);

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 6,
                      ),
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (index == data['selectedId'])
                            ? Colors.white
                            : Colors.blue[200],
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
                              color: (index == data['selectedId'])
                                  ? Colors.blue[200]
                                  : Colors.white,
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
                              color: (index == data['selectedId'])
                                  ? Colors.blue[200]
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
