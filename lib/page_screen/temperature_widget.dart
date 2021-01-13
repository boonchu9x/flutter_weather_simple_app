import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/setting_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/theme_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/setting_state.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/theme_state.dart';
import 'package:flutter_weather_simple_app/model/weather_data.dart';

import '../const.dart';

class TemperatureWidget extends StatelessWidget {
  final WeatherData weatherData;

  TemperatureWidget({
    Key key,
    @required this.weatherData,
  })  : assert(weatherData != null),
        super(key: key);

  //CONVERT celsius to fahrenheit
  int _convertToFahrenheit(double celsius) {
    return ((celsius * 9 / 5 + 32).round()); //.round() là làm tròn
  }

  //CONVERT FORMAT STRING °C/°F
  String _formatTemperature(double temp, TemperatureUnit temperatureUnit) {
    return temperatureUnit == TemperatureUnit.celsius
        ? '${temp.round()} °C'
        : '${_convertToFahrenheit(temp)} °F';
  }

  @override
  Widget build(BuildContext context) {
    //lấy theme state để set màu cho text và background
    ThemeState themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Min Temperature
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),

          //lấy ra setting bloc để thay đổi theme theo setting
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, settingState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, //aligment right
                children: [
                  Text(
                    'Min temp: ${_formatTemperature(weatherData.minTemp, settingState.temperatureUnit)}',
                    style: TextStyle(
                      color: themeState.textColor,
                      fontSize: textNormal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    'Temp: ${_formatTemperature(weatherData.temp, settingState.temperatureUnit)}',
                    style: TextStyle(
                      color: themeState.textColor,
                      fontSize: textNormal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    'Max temp: ${_formatTemperature(weatherData.maxTemp, settingState.temperatureUnit)}',
                    style: TextStyle(
                      color: themeState.textColor,
                      fontSize: textNormal,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
