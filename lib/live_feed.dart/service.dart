// weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '26a17a8d70974e57af4153717241309'; // Hardcoded API key
  final String baseUrl = 'https://api.weatherapi.com/v1/current.json';

  Future<Map<String, dynamic>> fetchWeather(String query) async {
    final url = '$baseUrl?q=$query&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (error) {
      print(error);
      return {};
    }
  }
}
