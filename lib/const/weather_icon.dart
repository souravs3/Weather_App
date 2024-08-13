import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String description;
  final double width;

  WeatherIcon({required this.description, required this.width});

  @override
  Widget build(BuildContext context) {
    return _getWeatherIcon(description, width);
  }

  Widget _getWeatherIcon(String description, double width) {
    switch (description.toLowerCase()) {
      case 'clouds':
        return Image.asset(
          'images/cloudy.png',
          width: width,
        );
      case 'rain':
        return Image.asset(
          'images/storm.png',
          width: width,
        );
      case 'sunny':
        return Image.asset(
          'images/sun.png',
          width: width,
        );
      case 'clear':
        return Image.asset(
          'images/weather-news.png',
          width: width,
        );
      default:
        return Image.asset('images/weather-news.png',
            width: width, color: Colors.white);
    }
  }
}
