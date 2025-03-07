import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.weatherapi.com/v1';
  final String apiKey;
  WeatherService(this.apiKey);
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL/current.json?key=$apiKey&q=$cityName&aqi=no'));
    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Weather Data');
    }
  }

  Future<String> getCurrentCity() async {
    // Get Permission from User
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    //fetch current Location 
    Position position = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy:  LocationAccuracy.high));

    //Convert the location into a list of placemark objects
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude,position.longitude);

    String? city = placemark[0].locality;

    return city ?? "";
  }
}