import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:http/http.dart' as http;

final List<Map<String, dynamic>> cities = [
  {'name': 'Paris', 'lat': 48.8566, 'lon': 2.3522, 'temperature': '', 'description': ''},
  {'name': 'London', 'lat': 51.5074, 'lon': -0.1278, 'temperature': '', 'description': ''},
  {'name': 'New York', 'lat': 40.7128, 'lon': -74.0060, 'temperature': '', 'description': ''},
  {'name': 'Tokyo', 'lat': 35.6895, 'lon': 139.6917, 'temperature': '', 'description': ''},
  {'name': 'Sydney', 'lat': -33.8688, 'lon': 151.2093, 'temperature': '', 'description': ''},
];

class LoaderWeatherScreen extends StatefulWidget {
  const LoaderWeatherScreen({Key? key}) : super(key: key);

  @override
  State<LoaderWeatherScreen> createState() => _LoaderWeatherScreenState();
}

class _LoaderWeatherScreenState extends State<LoaderWeatherScreen> {
  final ValueNotifier<double> valueNotifier = ValueNotifier(0);
  late Timer timer;
  int currentCityIndex = 0;

  @override
  void initState() {
    super.initState();
    startAnimation();
    startWeatherUpdates();
  }

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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return ListTile(
                  title: Text('${city['name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Temperature: ${city['temperature']}'),
                      Text('Description: ${city['description']}'),
                    ],
                  ),
                  onTap: () {
                    // Ajoutez ici la logique pour afficher les détails de la météo de la ville
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
