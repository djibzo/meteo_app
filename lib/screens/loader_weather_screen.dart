import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/utils/consts.dart';
import 'package:provider/provider.dart';

import '../services/weather_provider.dart';

class LoaderWeatherScreen extends StatefulWidget {
  const LoaderWeatherScreen({super.key});
  @override
  State<LoaderWeatherScreen> createState() => _LoaderWeatherScreenState();
}

class _LoaderWeatherScreenState extends State<LoaderWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    //final weatherData = Provider.of<WeatherProvider>(context).weatherData;
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final ValueNotifier<double> valueNotifier = ValueNotifier(0);
    return Scaffold(
    appBar: AppBar(
      foregroundColor: Colors.white,
      title: Text('Meteo App',),
      backgroundColor: appliColor,
      centerTitle: true,
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              child: CircularSeekBar(
                animDurationMillis:60000,
                width: double.infinity,
                height: 250,
                progress: 100,
                barWidth: 8,
                startAngle: 45,
                sweepAngle: 270,
                strokeCap: StrokeCap.butt,
                progressGradientColors: const [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.indigo, Colors.purple],
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
                child: Center(
                  child: ValueListenableBuilder(
                      valueListenable: valueNotifier,
                      builder: (_, double value, __) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${value.round()}', style: TextStyle(color: Colors.grey)),
                          Text('Progression', style:TextStyle(color: Colors.grey)),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
