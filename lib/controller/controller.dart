// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weather_project/model/city_model.dart';
import 'package:weather_project/model/forcast_model.dart';
import 'package:weather_project/model/history_model.dart';
import 'package:weather_project/model/weater_data_model.dart';
import 'package:weather_project/services/weather_service.dart';

class WeatherDataProvider extends ChangeNotifier {
  final WeatherAPIService _weatherAPIService = WeatherAPIService();

  CityModel? _cityModel;
  WeatherDatas? _weatherData;
  List<ForecastModel>? _forecastData;
  List<ForecastModel>? _weatherDataList;
  List<ForecastModel>? get weatherDataList => _weatherDataList;
  final List<CityTemp> _cityTempList = [];
  // Getter to access the forecast data list
  List<CityTemp> get cityTempList => _cityTempList;
  CityModel? get cityModel => _cityModel;
  WeatherDatas? get weatherData => _weatherData;
  List<ForecastModel>? get forecastData => _forecastData;

  Future<void> fetchCityInfo(String cityName) async {
    try {
      _cityModel = await _weatherAPIService.getCityInfo(cityName);
      notifyListeners();
    } catch (e) {
      print('Error fetching city info: $e');
    }
  }

  Future<void> fetchWeatherData(double lat, double lon) async {
    try {
      _weatherData = await _weatherAPIService.getWeatherData(lat, lon);
      notifyListeners();
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  Future<void> fetchWeatherDataList(double lat, double lon) async {
    try {
      _weatherDataList = await _weatherAPIService.getWeatherDataList(lat, lon);
      notifyListeners();
    } catch (error) {
      print('Error fetching weather data list: $error');
      // Handle error as per your requirement, like showing a snackbar or retry option.
    }
  }

  void addCityTemp(String cityName, double temperature) {
    // Check if the city name already exists in the list
    bool isDuplicate =
        _cityTempList.any((cityTemp) => cityTemp.cityName == cityName);

    if (!isDuplicate) {
      _cityTempList.add(CityTemp(cityName: cityName, temperature: temperature));
      print(temperature);
      print(cityName);
      notifyListeners(); // Notify listeners about the change in the list
    }
  }
}
