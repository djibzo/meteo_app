import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/CityDetail.dart';

class DetailScreen extends StatelessWidget {
  final CityDetail cityDetail;

  DetailScreen({required this.cityDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details de la ville'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body:  Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(cityDetail.name, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600,color: Colors.white)),
              Text(cityDetail.description, style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w300,color: Colors.white)),
              const SizedBox(height: 16),
              Text(cityDetail.temperature, style: const TextStyle(fontSize: 33,fontWeight: FontWeight.w300,color: Colors.white)),
              Text('Humidité: ${cityDetail.humidity}%', style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w300,color: Colors.white)),
            ],
          ),
        ),
      )
    );
  }
}
