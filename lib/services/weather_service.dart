import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String apiKey = '1ad70c255d37b6c6ec56da1c0a0ce3db';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data cuaca');
    }
  }
}