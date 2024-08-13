// ignore_for_file: avoid_print, use_build_context_synchronously, deprecated_member_use, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:weather_project/controller/controller.dart';
import 'package:weather_project/model/city_model.dart';
import 'package:weather_project/view/home_page.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherDataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter a city name to search:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: placeController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Search a city',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String cityName = placeController.text;
                    if (cityName.isNotEmpty) {
                      await weatherProvider.fetchCityInfo(cityName);
                      CityModel? cityInfo = weatherProvider.cityModel;

                      if (cityInfo != null) {
                        print(cityName);
                        print(cityInfo.lat);
                        print(cityInfo.lon);

                        await weatherProvider.fetchWeatherData(
                          cityInfo.lat,
                          cityInfo.lon,
                        );
                        await weatherProvider.fetchWeatherDataList(
                          cityInfo.lat,
                          cityInfo.lon,
                        );

                        // Check if weather data is available
                        if (weatherProvider.weatherData != null &&
                            weatherProvider.weatherData!.main != null &&
                            weatherProvider.weatherData!.main!.temp != null) {
                          double temperature = weatherProvider
                              .weatherData!.main!.temp!
                              .toDouble();
                          weatherProvider.addCityTemp(cityName, temperature);
                          print(weatherProvider.weatherData!.main!.temp);
                        } else {
                          print('Weather data not available');
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else {
                        // Handle when city is not found
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.blue,
                              title: const Text(
                                'City Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: const Text(
                                'Please enter a valid city name.',
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      // Handle empty city name
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text(
                              'Empty City Name',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              'Please enter a city name.',
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 10, 1, 138),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
