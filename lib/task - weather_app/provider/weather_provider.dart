import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/task%20-%20weather_app/modal/weather_modal.dart';

import '../../weather_helper/weather_api_helper.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherApiHelper weatherApiHelper = WeatherApiHelper();
  String searchWeather = "surat";
  WeatherModal? weatherModal;
  List<String> weather = [];
  List<double> temprecher = [];
  List<String> stu = [];
  String isDay = "";

  void searchWeatherAll(String search) {
    searchWeather = search;
    notifyListeners();
  }

Future<WeatherModal?> fromMap(String search)   async {
  Map<dynamic,dynamic> data= await weatherApiHelper.weather(search);
    weatherModal = WeatherModal.fromJson(data);
    return weatherModal;

  }

  Future<void> addFavourite(String name) async {
    String data = "$name";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather.add(data);
    sharedPreferences.setStringList('weather', weather);
  }

  Future<void> addFavouriteTemp(double temp) async {
    double data = temp;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    temprecher.add(temp);
    sharedPreferences.setStringList('weather', weather);
  }

  Future<void> addFavouriteStu(String line) async {
    String data = "$line";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    stu.add(line);
    sharedPreferences.setStringList('weather', weather);
  }

  Future<void> getFavouriteWeather() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> weather =
        sharedPreferences.getStringList('weather') ?? <String>[];
    print('$weather');
    notifyListeners();
  }



}
