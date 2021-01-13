import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_simple_app/model/weather_data.dart';

/*
STATE:
- Intial: khởi tạo
- Loading: load data
- Success: succecc get data
- Failure: error get data
*/

abstract class WeatherState extends Equatable{
  const WeatherState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

//INIT WEATHER STATE
class WeatherStateIntial extends WeatherState{

}


//LOADING
class WeatherStateLoading extends WeatherState{

}


//SUCCESS
class WeatherStateSuccess extends WeatherState{
  final WeatherData weatherData;
  const WeatherStateSuccess({@required this.weatherData}): assert(weatherData != null);
  @override
  // TODO: implement props
  List<Object> get props => [weatherData];

}



//FAILURE
class WeatherStateFailure extends WeatherState{

}

