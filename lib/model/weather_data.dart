import 'package:equatable/equatable.dart';

import '../const.dart';

//OBJECT. CONVERT JSON TO OBJECT

/*
consolidated_weather": [
{
"id": 5001437304061952,
"weather_state_name": "Light Cloud",
"weather_state_abbr": "lc",
"wind_direction_compass": "SSE",
"created": "2020-07-26T00:22:18.967978Z",
"applicable_date": "2020-07-25",
"min_temp": 22.825,
"max_temp": 31.585,
"the_temp": 32.2,
"wind_speed": 4.388510937739601,
"wind_direction": 165.1056162097894,
"air_pressure": 1018.5,
"humidity": 56,
"visibility": 15.249070428696413,
"predictability": 70
},
...*/

class WeatherData extends Equatable {
  final WeatherStatus weatherStatus;
  final String weatherStateName;
  final double minTemp;
  final double temp;
  final String time;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  WeatherData(
      {this.weatherStatus,
      this.weatherStateName,
      this.minTemp,
      this.temp,
      this.time,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location});

  @override
  // TODO: implement props
  List<Object> get props => [
        weatherStatus,
        weatherStateName,
        minTemp,
        temp,
        time,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location
      ];

  //map format weather state to string weather state
  static WeatherStatus _mapFormatToStringWeather(String formatWeather) {
    Map<String, WeatherStatus> map = {
      'sn': WeatherStatus.snow,
      'sl': WeatherStatus.sleet,
      'h': WeatherStatus.hail,
      't': WeatherStatus.thunderstorm,
      'hr': WeatherStatus.heavyRain,
      'lr': WeatherStatus.lightRain,
      's': WeatherStatus.showers,
      'hc': WeatherStatus.heavyCloud,
      'lc': WeatherStatus.lightCloud,
      'c': WeatherStatus.clear,
    };
    return map[formatWeather] ?? WeatherStatus.unknow;
  }

  //map json object to object WeatherData
  factory WeatherData.fromJson(dynamic jsonObject) {
    final item = jsonObject['consolidated_weather'][0];
    return WeatherData(
      weatherStatus:
          _mapFormatToStringWeather(item['weather_state_abbr']) ?? '',
      weatherStateName: item['weather_state_name'] ?? '',
      minTemp: item['min_temp'] as double,
      temp: item['the_temp'] as double,
      time: item['time'],
      maxTemp: item['max_temp'] as double,
      //Where On Earth Identifier = woeid
      locationId: jsonObject['woeid'] as int,
      created: item['created'],
      lastUpdated: DateTime.now(),
      location: jsonObject['title'],
    );
  }
}
