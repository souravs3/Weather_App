import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_project/const/api_const.dart';
import 'package:weather_project/model/city_model.dart';
import 'package:weather_project/model/forcast_model.dart';
import 'package:weather_project/model/weater_data_model.dart';

class WeatherAPIService {
  Future<CityModel?> getCityInfo(String cityName) async {
    final response = await http.get(
      Uri.parse('$geo/direct?q=$cityName&limit=0&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return CityModel.fromJson(data[0]);
      } else {
        return null;
      }
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception(
          'Failed to load city data. Status code: ${response.statusCode}');
    }
  }

  Future<WeatherDatas?> getWeatherData(double lat, double lon) async {
    final response = await http.get(
        Uri.parse('$weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? jsonData = json.decode(response.body);

      if (jsonData != null) {
        return WeatherDatas.fromJson(jsonData);
      } else {
        return null; // Return null if jsonData is null
      }
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }

  Future<List<ForecastModel>?> getWeatherDataList(
      double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&cnt=5'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load weather data list: ${response.statusCode}',
      );
    }

    try {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // Handle null or missing 'cnt' field in JSON response
      final int cnt = jsonData['cnt'] ?? 0;
      final List<dynamic>? weatherDataList = jsonData['list'];

      if (weatherDataList == null) {
        throw Exception('Weather data list is null');
      }

      final List<ForecastModel> parsedWeatherDataList = [];

      final currentDate = DateTime.now();

      for (var i = 0; i < cnt; i++) {
        final ForecastModel weatherData =
            ForecastModel.fromJson(weatherDataList[i]);
        final forecastDate =
            DateTime.fromMillisecondsSinceEpoch(weatherData.dt * 1000);

        if (forecastDate.isAfter(currentDate) &&
            forecastDate.difference(currentDate).inDays <= 5) {
          parsedWeatherDataList.add(weatherData);
        }
      }

      return parsedWeatherDataList;
    } catch (error) {
      throw Exception('Failed to decode JSON response');
    }
  }
}
