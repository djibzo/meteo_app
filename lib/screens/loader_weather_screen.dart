import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app/screens/details_screen.dart';

import '../utils/CityDetail.dart';

final List<Map<String, dynamic>> cities = [
  {'name': 'Dakar', 'lat': 14.499454, 'lon':-14.445561499999997 , 'temperature': '', 'description': ''},
  {'name': 'Kolda', 'lat': 12.88333, 'lon': -14.95, 'temperature': '', 'description': ''},
  {'name': 'Montréal', 'lat': 45.5031824, 'lon': -73.5698065, 'temperature': '', 'description': ''},
  {'name': 'Abidjan', 'lat': 5.320357, 'lon': -4.016107, 'temperature': '', 'description': ''},
  {'name': 'Paris', 'lat': 48.862725, 'lon': 2.287592, 'temperature': '', 'description': ''},
];

class LoaderWeatherScreen extends StatefulWidget {
  const LoaderWeatherScreen({Key? key}) : super(key: key);

  @override
  State<LoaderWeatherScreen> createState() => _LoaderWeatherScreenState();
}

class _LoaderWeatherScreenState extends State<LoaderWeatherScreen> {
  int _currentIndex = 0;
  late  final ValueNotifier<double> valueNotifier = ValueNotifier(0);
  late Timer timer;
  int currentCityIndex = 0;
  @override
  void initState() {
    super.initState();
    startAnimation();
    startWeatherUpdates();
    _startLTTimer();
  }
  void _startLTTimer() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (_currentIndex < cities.length - 1) {
          _currentIndex++;
        } else {
          timer.cancel(); // Arrête le timer une fois que toutes les villes ont été affichées
        }
      });
    });
  }//timer pour afficher les villes
  void startAnimation() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 600));
      valueNotifier.value = i.toDouble();
    }
  }

  void startWeatherUpdates() {
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      fetchWeatherDataForCity(cities[currentCityIndex]);
      currentCityIndex = (currentCityIndex + 1) % cities.length;
    });
  }

  Future<void> fetchWeatherDataForCity(Map<String, dynamic> city) async {
    final apiKey = '1785471ad8877e665b6758bee3ce3971';
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat=${city['lat']}&lon=${city['lon']}&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        city['temperature'] = '${data['main']['temp']} °C';
        city['description'] = data['weather'][0]['description'];
        city['humidity']='${data['main']['humidity']}';
      });
    } else {
      print('Failed to load weather data for ${city['name']}');
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: double.infinity,
              height: 250,
              child: CircularSeekBar(
                animDurationMillis: 60000,
                progress: 100,
                barWidth: 8,
                startAngle: 45,
                sweepAngle: 270,
                strokeCap: StrokeCap.butt,
                progressGradientColors: const [
                  Colors.red,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.indigo,
                  Colors.purple
                ],
                innerThumbRadius: 5,
                innerThumbStrokeWidth: 3,
                innerThumbColor: Colors.white,
                outerThumbRadius: 5,
                outerThumbStrokeWidth: 10,
                outerThumbColor: Colors.blueAccent,
                dashWidth: 1,
                dashGap: 2,
                animation: true,
                valueNotifier: valueNotifier,
                width: 500,
                height: 500,
                child: Center(
                  child: ValueListenableBuilder<double>(
                    valueListenable: valueNotifier,
                    builder: (_, double value, __) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${value.round()}', style: const TextStyle(color: Colors.grey)),
                        const Text('Progression', style: TextStyle(color: Colors.grey)),
                        //ListView.builder(itemBuilder: itemBuilder) a experimenter pour le chargement des messages
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _currentIndex + 1,
              itemBuilder: (context, index) {
                final city = cities[index];
                return  ListTile(
                  title: Text('${city['name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Temperature: ${city['temperature']}'),
                      Text('Couverture nuageuse: ${city['description']}'),
                    ],
                  ),
                  onTap: () {
                    CityDetail cityDetail = CityDetail(
                      name: city['name'],
                      temperature: city['temperature'],
                      description: city['description'], humidity: city['humidity'],

                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DetailScreen(cityDetail: cityDetail,);
                    },));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
