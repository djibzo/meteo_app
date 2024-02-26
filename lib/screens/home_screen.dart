import 'package:flutter/material.dart';
import 'package:meteo_app/utils/consts.dart';

import 'loader_weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});


  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appliColor,
        title: Text(widget.title),
      ),
      body:  Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text(
                'Bienvenue dans Meteo App ! ',style: TextStyle(fontSize: 30),
              ),
            ),
            IconButton(
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoaderWeatherScreen();
                  },));
                },
                icon: Icon(Icons.start,size: 40,color: appliColor,),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}