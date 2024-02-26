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
        centerTitle: true,
        title: Text(widget.title,style: TextStyle(color: Colors.white,),),
      ),
      body:
        Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/background.jpeg'),
        fit: BoxFit.cover,
        ),
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 80,bottom: 10),
              child: Text(
                'Bienvenue dans Meteo App ! ',style: TextStyle(fontSize: 30),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(18.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LoaderWeatherScreen();
                      },));
                    },
                    child: const Text('C\'est parti'),
                  ),
                ],
              ),
            ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     foregroundColor: appliColor,
            //     padding: const EdgeInsets.all(16.0),
            //     textStyle: const TextStyle(fontSize: 20),
            //   ),
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return LoaderWeatherScreen();
            //     },));
            //   },
            //   child: const Text('C\'est parti !'),
            // ),
            // IconButton(
            //   onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) {
            //         return LoaderWeatherScreen();
            //       },));
            //     },
            //     icon: Icon(Icons.start,size: 40,color: appliColor,),
            // )
          ],
        ),
      ),),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}