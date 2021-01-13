import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_simple_app/const.dart';

/*
* THEME STATE
* thay đổi các thông tin về background color/ text color
* */

class ThemeState extends Equatable {
  final Color backgroundColor;
  final Color textColor;

  const ThemeState({@required this.backgroundColor, @required this.textColor})
      : assert(backgroundColor != null),
        assert(textColor != null);

  @override
  // TODO: implement props
  List<Object> get props => [backgroundColor, textColor];
}
