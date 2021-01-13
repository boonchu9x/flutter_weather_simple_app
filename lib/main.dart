import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/theme_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/weather_bloc_observer.dart';
import 'package:flutter_weather_simple_app/network/weather_response.dart';
import 'package:flutter_weather_simple_app/page_screen/setting_page.dart';
import 'package:flutter_weather_simple_app/page_screen/weather_page.dart';
import 'package:http/http.dart' as http;

import 'flutter_bloc/bloc/setting_bloc.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherResponsitory weatherResponsitory =
      WeatherResponsitory(httpClient: http.Client());

  //Multi Bloc
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(weatherResponsitory: weatherResponsitory)),
      BlocProvider<SettingBloc>(create: (context) => SettingBloc())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //index
  int _indexSelected = 0;

  //list page fragment
  final List<Widget> _children = [
    WeatherScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //load boby follow index selected
      body: _children[_indexSelected],
      //bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Weather',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              'Setting',
            ),
          ),
        ],
        currentIndex: _indexSelected,
        onTap: onTapItem,
      ),
    );
  }

  //func tap change select
  void onTapItem(int index) {
    setState(() {
      _indexSelected = index;
    });
  }
}
