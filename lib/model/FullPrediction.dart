import 'package:aemet_radar/model/HourlyPrediction.dart';
import 'package:aemet_radar/model/DailyPrediction.dart';

class FullPrediction {
  final String town;
  final String province;
  List<FullPredictionDay> days;

  FullPrediction(this.town, this.province, this.days);
}

class FullPredictionDay {
  final DateTime date;
  final String uvMax;
  List<RainProbability> rainProbability;
  List<SnowLevelProbability> snowLevelProbability;
  List<SkyStatus> skyStatus;
  List<DailyWind> wind;
  List<MaxWindGust> maxWindGust;
  final Temperature temperature;
  final ThermalSensation thermalSensation;
  final RelativeHumidity relativeHumidity;
  List<PredictionHour> hours;
  List<PredictionHourRange> hourRanges;
  DateTime orto;
  DateTime ocaso;

  FullPredictionDay(this.date, this.uvMax, this.rainProbability, this.snowLevelProbability,
      this.skyStatus, this.wind, this.maxWindGust, this.temperature,
      this.thermalSensation, this.relativeHumidity, {this.hours, this.hourRanges, this.orto,
      this.ocaso});
}