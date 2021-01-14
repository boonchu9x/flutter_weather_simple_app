import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_simple_app/component/searchbar.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/theme_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/theme_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/event/weather_event.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/theme_state.dart';
import 'package:flutter_weather_simple_app/flutter_bloc/states/weather_state.dart';
import 'package:flutter_weather_simple_app/page_screen/temperature_widget.dart';

import '../const.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _textEditingController = TextEditingController();
  Color colorSearchBar = Colors.black12.withOpacity(0.1);

  //tương đương với Future
  Completer<void> _completer;

  void search() {
    if (_textEditingController != null &&
        _textEditingController.text.isNotEmpty) {
      //hide keyboard
      FocusScope.of(context).requestFocus(FocusNode());
      //search weather by city in search
      BlocProvider.of<WeatherBloc>(context)
          .add(WeatherEventRequested(city: _textEditingController.text.trim()));
    }
  }

  void backSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_textEditingController != null &&
        _textEditingController.text.isNotEmpty){
      _textEditingController.clear(); //clear text in textfeild
      BlocProvider.of<WeatherBloc>(context).add(WeatherEventInitial());
    }
    else
      SystemNavigator.pop(); // exit app
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up the controller when the widget is disposed.
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SearchBar(
            context: context,
            textEditingController: _textEditingController,
            leadingOnPress: () => backSearch(),
            searchOnPress: () => search(),
          ),
          BlocConsumer<WeatherBloc, WeatherState>(
            //lắng nghe bloc
            listener: (context, weatherState) {
              //khi nhận được state chính là weatherState từ server thì thay đổi theme theo trạng thái thời tiết
              if (weatherState is WeatherStateSuccess) {
                BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                    weatherStatus: weatherState.weatherData.weatherStatus));

                //completer hoàn thành
                _completer?.complete();
                _completer = Completer();
              }
            },
            builder: (context, weatherState) {
              //state là intial
              if(weatherState is WeatherStateIntial){
                return buildIntialWidget();
              }


              //nếu state(weatherState) là loading thì hiện loading dialog
              if (weatherState is WeatherStateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              //nếu state(weatherState) là thành công: refresh screen
              if (weatherState is WeatherStateSuccess) {
                final weather = weatherState.weatherData;
                return BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, themeState) {
                      return RefreshIndicator(
                        onRefresh: () {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(WeatherEventRefresh(city: weather.location));
                          //return a completer object
                          return _completer.future;
                        },
                        //UI
                        child: Container(
                          //change color background follow themeState
                          color: themeState.backgroundColor,
                          child: Stack(

                            children: [
                              //SEARCH BAR
                              SearchBar(
                                context: context,
                                textEditingController: _textEditingController,
                                leadingOnPress: () => backSearch(),
                                searchOnPress: () => search(),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [




                                  TemperatureWidget(weatherData: weather),



                                  //SHOW MORE
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }

              //nếu failure
              if (weatherState is WeatherStateFailure) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: SvgPicture.asset(
                            'assets/images/ic_error.svg',
                            colorBlendMode: BlendMode.color,
                          )),
                      RichText(
                        text: TextSpan(
                          text: 'Some thing went wrong!',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                            fontSize: textNormal,
                          ),
                          children: [
                            TextSpan(
                              text: ' Try again.',
                              style: TextStyle(
                                color: Colors.blue[400],
                                fontWeight: FontWeight.normal,
                                fontSize: textNormal,
                              ),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => {
                                  search(),
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return buildIntialWidget();
            },
          ),
        ],
      ),
    );
  }



  Align buildIntialWidget(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 20.0,
        ),
        child: OutlineButton(
          highlightedBorderColor: Colors.transparent,
          color: Colors.white,
          padding:
          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
          onPressed: () {},
          child: Text(
            'Choose Location',
            style: TextStyle(
              color: Colors.blue[400],
              fontSize: textNormal,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

}
