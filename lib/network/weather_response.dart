import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_simple_app/const.dart';
import 'package:flutter_weather_simple_app/model/weather_data.dart';
import 'package:http/http.dart' as http;

//CONNECT TO API BY HTTP

/*
api
Info Weather from API:
https://www.metaweather.com

Search by City:
https://www.metaweather.com/api/location/search/?query=(query)

Search by Lat,Long:
https://www.metaweather.com/api/location/(location)
*/

final locationUrl = (city) => '${baseUrl}/api/location/search/?query=${city}';
final weatherUrl = (locationId) => '${baseUrl}/api/location/${locationId}';

class WeatherResponsitory {
  final http.Client httpClient;

  //contructor
  WeatherResponsitory({@required this.httpClient}) : assert(httpClient != null);

  //get location from city
  Future<int> getLocationFromCity(String city) async {
    final response = await this.httpClient.get(locationUrl(city));
    //success
    if (response.statusCode == 200) {
      //
      final cities = jsonDecode(response.body) as List;
      //get element first in list with property int 'woeid'
      return (cities.first)['woeid'] ?? Map();
    } else {
      //error
      throw Exception('Error getting location id of: ${city}');
    }
  }

  //get weather from location id
  Future<WeatherData> fetchWeather(int locationId) async {
    final response = await this.httpClient.get(weatherUrl(locationId));
    if (response.statusCode != 200)
      throw Exception('Error getting weather from locationId: ${locationId}');
    final weatherJson = jsonDecode(response.body);
    return WeatherData.fromJson(weatherJson);
  }

  //get weather from city
  Future<WeatherData> getWeatherFromCity(String city) async{
    final int locationId = await getLocationFromCity(city);
    return fetchWeather(locationId);
  }

}
