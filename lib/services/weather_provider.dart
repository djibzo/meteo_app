import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/services/weather_api.dart';
import '../models/location_data.dart';
import '../models/weather_data.dart';
class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;
  LocationData? _locationData;
  WeatherProvider() {
    _locationData = LocationData(latitude: 0.0, longitude: 0.0); // Initialize with default location
    fetchWeatherData();
  }
  WeatherData? get weatherData => _weatherData;
  LocationData? get locationData => _locationData;
  void setLocation(double latitude, double longitude) {
    _locationData = LocationData(latitude: latitude, longitude: longitude);
    fetchWeatherData();
  }
  Future<void> fetchWeatherData() async {
    try {
      final api = WeatherApi(apiKey: '1785471ad8877e665b6758bee3ce3971');
      final data = await api.fetchWeatherData(_locationData!.latitude, _locationData!.longitude);
      _weatherData = WeatherData(
        city: data['name'],
        description: data['weather'][0]['description'],
        temperature: data['main']['temp'],
        humidity: data['main']['humidity'],
        iconCode: data['weather'][0]['icon'],
      );
      notifyListeners();
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }
}