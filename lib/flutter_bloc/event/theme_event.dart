import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_simple_app/const.dart';
import 'package:flutter_weather_simple_app/model/weather_data.dart';


/*
* THEME EVENT:
* thay đổi theme: background, icon, text color....
* hoặc các thông số theo enum WeatherState thời tiết
* */

abstract class ThemeEvent extends Equatable{
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent{
  final WeatherStatus weatherStatus;
  const ThemeEventWeatherChanged({@required this.weatherStatus}): assert(weatherStatus != null);

  @override
  // TODO: implement props
  List<Object> get props => [weatherStatus];

}