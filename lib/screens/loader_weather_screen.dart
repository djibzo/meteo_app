import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/utils/consts.dart';

class LoaderWeatherScreen extends StatefulWidget {
  const LoaderWeatherScreen({super.key});

  @override
  State<LoaderWeatherScreen> createState() => _LoaderWeatherScreenState();
}

class _LoaderWeatherScreenState extends State<LoaderWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      foregroundColor: Colors.white,
      title: Text('Meteo App',),
      backgroundColor: appliColor,
      centerTitle: true,
    ),
    );
  }
}
