import 'package:aemet_radar/model/LocationOption.dart';
import 'package:aemet_radar/model/LocationWeather.dart';

class SearchState { }

class Idle extends SearchState {}

class Busy extends SearchState {}

class Error extends SearchState {
  final String message;
  Error(this.message);
}

class OptionsResult extends SearchState {
  final List<LocationOption> options;
  OptionsResult(this.options);
}

class LocationResult extends SearchState {
  final LocationWeather locationWeather;
  LocationResult(this.locationWeather);
}

class WeatherResult extends SearchState {}