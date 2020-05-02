class HourlyPrediction {
  final String town;
  final String province;
  final List<HourlyPredictionDay> days;

  HourlyPrediction(this.town, this.province, this.days);
}

class HourlyPredictionDay {
  final DateTime date;
  final List<PredictionHour> hours;
  final List<PredictionHourRange> hourRanges;
  final DateTime orto;
  final DateTime ocaso;

  HourlyPredictionDay(this.date, this.hours, this.hourRanges, this.orto, this.ocaso);
}

class PredictionHour {
  final DateTime hour;
  final String temperature;
  final String thermalSensation;
  final String relativeHumidity;
  final Wind wind;
  final String rainfallMM;
  final String snowMM;
  final String skyStatus;

  PredictionHour(this.hour, this.temperature, this.thermalSensation,
      this.relativeHumidity, this.wind, this.rainfallMM, this.snowMM,
      this.skyStatus);
}

class PredictionHourRange {
  final DateTime startTime;
  final DateTime endTime;
  final String rainProbability;
  final String stormProbability;
  final String snowProbability;

  PredictionHourRange(this.startTime, this.endTime, this.rainProbability,
      this.stormProbability, this.snowProbability);
}

class Wind {
  final String direction;
  final String velocity;
  final String maxWindGust;

  Wind(this.direction, this.velocity, this.maxWindGust);
}