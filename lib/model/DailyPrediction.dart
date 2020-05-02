class DailyPrediction {
  final List<DailyPredictionDay> days;

  DailyPrediction(this.days);
}

class DailyPredictionDay {
  final DateTime date;
  final String uvMax;
  final List<RainProbability> rainProbability;
  final List<SnowLevelProbability> snowLevelProbability;
  final List<SkyStatus> skyStatus;
  final List<DailyWind> wind;
  final List<MaxWindGust> maxWindGust;
  final Temperature temperature;
  final ThermalSensation thermalSensation;
  final RelativeHumidity relativeHumidity;

  DailyPredictionDay(this.date, this.uvMax, this.rainProbability,
      this.snowLevelProbability, this.skyStatus, this.wind, this.maxWindGust,
      this.temperature, this.thermalSensation, this.relativeHumidity);
}

class RainProbability {
  final Period period;
  final String value;

  RainProbability(this.period, this.value);
}

class SnowLevelProbability {
  final Period period;
  final String value;

  SnowLevelProbability(this.period, this.value);
}

class SkyStatus {
  final Period period;
  final String value;

  SkyStatus(this.period, this.value);
}

class DailyWind {
  final Period period;
  final String value;
  final String direction;

  DailyWind(this.period, this.value, this.direction);
}

class MaxWindGust {
  final Period period;
  final String value;

  MaxWindGust(this.period, this.value);
}

class Temperature {
  final String max;
  final String min;
  final List<HourData> data;

  Temperature(this.max, this.min, this.data);
}

class ThermalSensation {
  final String max;
  final String min;
  final List<HourData> data;

  ThermalSensation(this.max, this.min, this.data);
}

class RelativeHumidity {
  final String max;
  final String min;
  final List<HourData> data;

  RelativeHumidity(this.max, this.min, this.data);
}

class HourData {
  final String value;
  final DateTime hour;

  HourData(this.value, this.hour);
}

class Period {
  final DateTime startTime;
  final DateTime endTime;

  Period(this.startTime, this.endTime);
}