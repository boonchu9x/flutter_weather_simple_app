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
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, settingState) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, //aligment right
              children: [
                //ICON CLOUD AND TEXT TEMPERATURE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: themeState.textColor,
                      size: 18.0,
                    ),

                    SizedBox(
                      width: 5.0,
                    ),
                    //TEXT LOCATION
                    Text(
                      '${weatherData.location}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: textTitle,
                        color: themeState.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                //ICON CLOUD AND TEXT TEMPERATURE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wb_cloudy,
                      color: themeState.textColor,
                      size: 40.0,
                    ),
                    Text(
                      ' ${_formatTemperature(weatherData.temp, settingState.temperatureUnit)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textTemperature,
                        color: themeState.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),

                //TEXT WEATHER
                Text(
                  '${weatherData.weatherStateName}',
                  style: TextStyle(
                    color: themeState.textColor,
                    fontSize: textTitle,
                  ),
                ),

                SizedBox(
                  height: 40.0,
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.white,
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            children: [
                              Text(
                                'Min Temp',
                                style: TextStyle(),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${_formatTemperature(weatherData.minTemp, settingState.temperatureUnit)}',
                                style: TextStyle(
                                  color: themeState.textColor,
                                  fontSize: textBig,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.white,
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            children: [
                              Text(
                                'Temp',
                                style: TextStyle(),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${_formatTemperature(weatherData.temp, settingState.temperatureUnit)}',
                                style: TextStyle(
                                  color: themeState.textColor,
                                  fontSize: textBig,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.white,
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            children: [
                              Text(
                                'Max Temp',
                                style: TextStyle(),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${_formatTemperature(weatherData.maxTemp, settingState.temperatureUnit)}',
                                style: TextStyle(
                                  color: themeState.textColor,
                                  fontSize: textBig,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
