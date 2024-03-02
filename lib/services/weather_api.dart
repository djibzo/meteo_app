import 'dart:convert';
import 'package:http/http.dart' as http;
class WeatherApi {
  final String apiKey;
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  WeatherApi({required this.apiKey});
  Future<Map<String, dynamic>> fetchWeatherData(double latitude, double longitude) async {
    final response = await http.get('$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric' as Uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}