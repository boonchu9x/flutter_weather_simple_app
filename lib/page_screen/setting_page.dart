import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/setting_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/setting_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/setting_state.dart';

import '../const.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 48.0,
          title: Center(
            child: Text(
              'Setting',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: textTitle,
              ),
            ),
          ),
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            BlocBuilder<SettingBloc, SettingState>(
              builder: (context, settingState) {
                return ListTile(
                  title: Text('Temperature Unit'),
                  isThreeLine: true,
                  subtitle: Text(
                      settingState.temperatureUnit == TemperatureUnit.celsius
                          ? 'Celsius'
                          : 'Fahrenheit'
                  ),
                  trailing: Switch(
                      value: settingState.temperatureUnit == TemperatureUnit.celsius,

                      //bắt sự kiện thay đổi switch
                      onChanged: (value) => BlocProvider.of<SettingBloc>(context).add(SettingEventToggleUnit()),
                  ),
                );
              },

            )
          ],
        )
    );
  }
}
