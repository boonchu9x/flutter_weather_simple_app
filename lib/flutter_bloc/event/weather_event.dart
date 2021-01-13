import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/*
EVENT:
- Refresh data
- Rquested to get data

*/

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventInitial extends WeatherEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

//REQUEST
class WeatherEventRequested extends WeatherEvent {
  final String city;

  //check city != null
  const WeatherEventRequested({@required this.city}) : assert(city != null);

  @override
  // TODO: implement props
  List<Object> get props => [city];
}


//REFRESH
class WeatherEventRefresh extends WeatherEvent {
  final String city;

  const WeatherEventRefresh({@required this.city}) : assert(city != null);

  @override
  // TODO: implement props
  List<Object> get props => [city];
}
