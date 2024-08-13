// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/controller/controller.dart';
import 'package:weather_project/view/home_page.dart';

class WeatherHistory extends StatelessWidget {
  const WeatherHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the WeatherDataProvider using Provider
    final weatherProvider = Provider.of<WeatherDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Weather History',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black, // Changed background color to black
      body: ListView.builder(
        itemCount: weatherProvider.cityTempList.length,
        itemBuilder: (context, index) {
          final cityTemp = weatherProvider.cityTempList[index];
          return InkWell(
            onTap: () async {
              // Fetch city info and weather data
              await weatherProvider.fetchCityInfo(cityTemp.cityName);
              if (weatherProvider.cityModel != null) {
                await weatherProvider.fetchWeatherData(
                  weatherProvider.cityModel!.lat,
                  weatherProvider.cityModel!.lon,
                );
                // Navigate to home page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
            },
            child: ListTile(
              title: Text(
                cityTemp.cityName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Temperature: ${cityTemp.temperature.toInt()}°C',
                style: const TextStyle(
                  color: Colors.white,
                ), // Changed text color to white
              ),
            ),
          );
        },
      ),
    );
  }
}
