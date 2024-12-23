import 'package:flutter/material.dart';
import 'package:tugasdataapi/services/weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  final TextEditingController cityController = TextEditingController();
  Map<String, dynamic>? weatherData;

  void fetchWeather() async {
    try {
      final data = await weatherService.fetchWeather(cityController.text);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Cuaca'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Masukkan Nama Kota',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: fetchWeather,
              icon: Icon(Icons.cloud_outlined),
              label: Text('Penelusuran Cuaca'),
            ),
            SizedBox(height: 20),
            if (weatherData != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuaca di ${weatherData!['name']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Suhu: ${weatherData!['main']['temp']}°C'),
                    Text('Cuaca: ${weatherData!['weather'][0]['description']}'),
                    Text('Kecepatan Angin: ${weatherData!['wind']['speed']} m/s'),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
}        