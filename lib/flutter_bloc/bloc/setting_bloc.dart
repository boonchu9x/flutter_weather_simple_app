import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_simple_app/const.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/setting_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  //khởi tạo setting state ban đầu là celsius
  SettingBloc() : super(SettingState(temperatureUnit: TemperatureUnit.celsius));


  //map event to state
  //sử dụng async* để có thể yield nhiều giá trị
  @override
  Stream<SettingState> mapEventToState(SettingEvent settingEvent) async*{
    //switch farenheit
    if(settingEvent is SettingEventToggleUnit){
      yield SettingState(temperatureUnit: settingEvent == TemperatureUnit.celsius ? TemperatureUnit.farenheit : TemperatureUnit.celsius);
    }
  }
}
