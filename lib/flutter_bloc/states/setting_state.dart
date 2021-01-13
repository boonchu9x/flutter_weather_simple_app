import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_simple_app/const.dart';

/*
* SETTING STATE
* chỉ thay đổi độ C => độ F
* */

 class SettingState extends Equatable{
  final TemperatureUnit temperatureUnit;
  const SettingState({@required this.temperatureUnit}): assert(temperatureUnit != null);

  @override
  // TODO: implement props
  List<Object> get props => [temperatureUnit];
}