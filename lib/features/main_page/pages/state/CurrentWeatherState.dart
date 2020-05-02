import 'package:aemet_radar/model/FullPrediction.dart';

class CurrentWeatherState {}

class NoData extends CurrentWeatherState {}

class Busy extends CurrentWeatherState {}

class Result extends CurrentWeatherState {
  final FullPrediction result;

  Result(this.result);
}

class Error extends CurrentWeatherState {}
