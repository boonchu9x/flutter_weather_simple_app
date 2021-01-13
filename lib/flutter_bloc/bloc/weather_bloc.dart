import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/weather_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/weather_state.dart';
import 'package:flutter_weather_simple_app/model/weather_data.dart';
import 'package:flutter_weather_simple_app/network/weather_response.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherResponsitory weatherResponsitory;

  WeatherBloc({@required this.weatherResponsitory})
      : assert(weatherResponsitory != null),
        super(WeatherStateIntial()); //khởi tạo state ban đầu

  //map event to state
  //sử dụng async* để có thể yield nhiều giá trị
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    // nếu event là request thì yield ra weather loading
    if (weatherEvent is WeatherEventRequested) {
      yield WeatherStateLoading();

      //get data
      try {
        //get weather from city thì yield ra response weather data
        final WeatherData weatherData =
            await weatherResponsitory.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weatherData: weatherData);
      } catch (exception) {
        //faild
        yield WeatherStateFailure();
      }
    }
    else if(weatherEvent is WeatherEventInitial){
      yield WeatherStateIntial();
    }
    else if (weatherEvent is WeatherEventRefresh) //nếu event là refresh
    {
      yield WeatherStateLoading();
      //get data
      try {
        //get weather from city thì yield ra response weather data
        final WeatherData weatherData =
            await weatherResponsitory.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weatherData: weatherData);
      } catch (exception) {
        //faild
        yield WeatherStateFailure();
      }
    }
  }
}
