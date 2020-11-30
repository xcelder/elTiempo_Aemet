import 'package:aemet_radar/model/HourlyPrediction.dart';
import 'package:aemet_radar/model/DailyPrediction.dart';

class FullPrediction {
  final String town;
  final String province;
  List<FullPredictionDay> days;

  FullPrediction(this.town, this.province, this.days);

  FullPredictionDay getPredictionForDay(DateTime dateTime) {
    return days.firstWhere((predictionDay) {
      return predictionDay.date.day == dateTime.day;
    });
  }

  PredictionHourRange getPredictionRangeForHour(DateTime dateTime) {
    for (int i = 0; i < days.length; i++) {
      final day = days[i];

      if (day.hourRanges != null) {
        for (int j = 0; j < day.hourRanges.length; j++) {
          final hourRange = day.hourRanges[j];

          if (hourRange.startTime.isBefore(dateTime) &&
              hourRange.endTime.isAfter(dateTime)) {
            return hourRange;
          }
        }
      }
    }

    return null;
  }
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

  FullPredictionDay(
      this.date,
      this.uvMax,
      this.rainProbability,
      this.snowLevelProbability,
      this.skyStatus,
      this.wind,
      this.maxWindGust,
      this.temperature,
      this.thermalSensation,
      this.relativeHumidity,
      {this.hours,
      this.hourRanges,
      this.orto,
      this.ocaso});

  PredictionHour getPredictionForHour(DateTime dateTime) {
    return hours.firstWhere((predictionHour) {
      return predictionHour.hour.hour == dateTime.hour;
    });
  }
}
