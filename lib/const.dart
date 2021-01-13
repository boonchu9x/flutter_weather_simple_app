import 'package:flutter/material.dart';


enum WeatherStatus {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknow
}

enum TemperatureUnit{
  farenheit,
  celsius
}


const baseUrl = 'https://www.metaweather.com';

Color colorTheme = Colors.deepOrange[400];


const double textSuperSmall = 10.0;
const double textSmall = 12.0;
const double textMedium = 14.0;
const double textNormal = 16.0;
const double textTitle = 18.6;
const double textBig = 20.0;
const double textToolbar = 28.0;
const double textSuperBig = 28.0;
const double textSuperSuperBig = 36.0;
