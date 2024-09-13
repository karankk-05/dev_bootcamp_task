
import 'package:flutter/material.dart';

import 'service.dart';

class LiveFeed extends StatefulWidget {
  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  final WeatherService _weatherService = WeatherService();
  Future<Map<String, dynamic>>? _weatherData;
  final TextEditingController _locationController =
      TextEditingController(); // TextField controller
  String _query = 'Kanpur'; // Default query for the weather data

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _weatherData = _weatherService
          .fetchWeather(_query); // Use the updated query for weather data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Weather Feed'),
      ),
      body: Column(
        children: [
          // Input field to enter custom query
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _query = _locationController
                          .text; // Update the query with user input
                      _fetchWeatherData(); // Fetch the weather for the new query
                    });
                  },
                ),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() {
                  _query = value; // Update the query when user submits
                  _fetchWeatherData(); // Fetch the weather for the new query
                });
              },
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchWeatherData,
              child: FutureBuilder<Map<String, dynamic>>(
                future: _weatherData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return Center(child: Text('Failed to load weather data.'));
                  } else {
                    final weather = snapshot.data!;
                    final location = weather['location'];
                    final current = weather['current'];

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Location details
                            Text(
                              '${location['name']}, ${location['region']}',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${location['country']}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            SizedBox(height: 16),

                            // Weather icon and temperature
                            Image.network(
                                'https:${current['condition']['icon']}',
                                scale: 0.6),
                            Text(
                              '${current['temp_c']}°C',
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              current['condition']['text'],
                              style: TextStyle(
                                  fontSize: 24, color: Colors.blueGrey),
                            ),
                            SizedBox(height: 16),

                            // Weather details
                            _buildWeatherDetailRow(
                                'Feels Like', '${current['feelslike_c']}°C'),
                            _buildWeatherDetailRow('Wind',
                                '${current['wind_kph']} kph, ${current['wind_dir']}'),
                            _buildWeatherDetailRow(
                                'Humidity', '${current['humidity']}%'),
                            _buildWeatherDetailRow(
                                'Visibility', '${current['vis_km']} km'),
                            _buildWeatherDetailRow(
                                'Pressure', '${current['pressure_mb']} mb'),
                            _buildWeatherDetailRow(
                                'UV Index', '${current['uv']}'),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to display weather details in a row
  Widget _buildWeatherDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
