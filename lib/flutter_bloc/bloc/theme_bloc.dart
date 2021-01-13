import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_simple_app/const.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/setting_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/theme_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/weather_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/setting_state.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/theme_state.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/weather_state.dart';
import 'package:flutter_weather_simple_app/model/weather_data.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //khởi tạo theme state ban đầu: background và text color
  ThemeBloc()
      : super(ThemeState(
            backgroundColor: Colors.blue[400], textColor: Colors.white));

  //map event to state
  //sử dụng async* để có thể yield nhiều giá trị
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    ThemeState themeState;
    if (themeEvent is ThemeEventWeatherChanged) {
      //thay đổi theme app theo các trạng thái của thời tiết
      final WeatherStatus weatherStatus = themeEvent.weatherStatus;
      if (weatherStatus == WeatherStatus.clear ||
          weatherStatus == WeatherStatus.lightCloud) {
        //nếu thời tiết clear và lightCloud thì set background màu trắng, chữ màu đen
        themeState =
            ThemeState(backgroundColor: Colors.blue[200], textColor: Colors.black87);
      } else if (weatherStatus == WeatherStatus.hail ||
          weatherStatus == WeatherStatus.snow ||
          weatherStatus == WeatherStatus.sleet) {
        //nếu thời tiết ẩm ướt/có tuyết.. thì set background màu gray, color black
        themeState = ThemeState(backgroundColor: Colors.white, textColor: Colors.black87);
      }else if(weatherStatus == WeatherStatus.heavyCloud){
        themeState = ThemeState(backgroundColor: Colors.blue[400], textColor: Colors.white);
      } else if(weatherStatus == WeatherStatus.heavyRain || weatherStatus == WeatherStatus.lightRain || weatherStatus == WeatherStatus.showers){
        themeState = ThemeState(backgroundColor: Colors.grey[400], textColor: Colors.blue[500]);
      }else if(weatherStatus == WeatherStatus.thunderstorm){
        themeState = ThemeState(backgroundColor: Colors.grey[400], textColor: Colors.black);
      }else{
        themeState = ThemeState(backgroundColor: Colors.amber, textColor: Colors.black);
      }


      //yiel theme
      yield themeState;
    }
  }
}
