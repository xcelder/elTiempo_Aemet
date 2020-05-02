import 'dart:convert';

import 'package:aemet_radar/model/DailyPrediction.dart';
import 'package:aemet_radar/service/parser/OpenDataDynamicParser.dart';
import 'package:aemet_radar/service/responses/DailyPredictionResponse.dart';
import 'package:intl/intl.dart';
import 'package:aemet_radar/utils/DateTimeExtensions.dart';

class DailyPredictionParser implements OpenDataDynamicParser<DailyPrediction> {
  @override
  DailyPrediction parse(String data) {
    final Map<String, dynamic> jsonBody =
        (jsonDecode(data) as List<dynamic>).first;
    final dailyPredictionResponse = DailyPredictionResponse.fromJson(jsonBody);

    return _fromResponse(dailyPredictionResponse);
  }

  DailyPrediction _fromResponse(DailyPredictionResponse response) {
    final days = _parseDays(response.prediccion.dia);

    return DailyPrediction(days);
  }

  List<DailyPredictionDay> _parseDays(List<Dia> days) {
    return days.map((day) => _parseDay(day)).toList();
  }

  DailyPredictionDay _parseDay(Dia day) {
    final dateFormat = DateFormat("yyyy-MM-DDTHH:mm:ss");

    final date = dateFormat.parse(day.fecha);
    final uvMax = day.uvMax.toString();
    final rainProbability = _parseRainProbability(date, day.probPrecipitacion);
    final snowLevelProbability =
        _parseSnowLevelProbability(date, day.cotaNieveProv);
    final skyStatus = _parseSkyStatus(date, day.estadoCielo);
    final wind = _parseDailyWind(date, day.viento);
    final maxWindGust = _parseMaxWindGust(date, day.rachaMax);
    final temperature = _parseTemperature(date, day.temperatura);
    final thermalSensation = _parseThermalSensation(date, day.sensTermica);
    final relativeHumidity = _parseRelativeHumidity(date, day.humedadRelativa);

    return DailyPredictionDay(
      date,
      uvMax,
      rainProbability,
      snowLevelProbability,
      skyStatus,
      wind,
      maxWindGust,
      temperature,
      thermalSensation,
      relativeHumidity,
    );
  }

  List<RainProbability> _parseRainProbability(
      DateTime date, List<ProbPrecipitacion> probPrecipitacion) {
    return probPrecipitacion.map((rainProbability) {
      Period period;

      if (rainProbability.periodo != null) {
        final periodSplit = rainProbability.periodo.split("-");

        final startDate = date.setHour(int.parse(periodSplit.first));
        final endDate = date.setHour(int.parse(periodSplit[1]));
        period = Period(startDate, endDate);
      }

      final value = rainProbability.value;

      return RainProbability(period, value.toString());
    }).toList();
  }

  List<SnowLevelProbability> _parseSnowLevelProbability(
      DateTime date, List<CotaNieveProv> cotaNieveProv) {
    return cotaNieveProv.map((snowLevelProbability) {
      Period period;

      if (snowLevelProbability.periodo != null) {
        final periodSplit = snowLevelProbability.periodo.split("-");

        final startDate = date.setHour(int.parse(periodSplit.first));
        final endDate = date.setHour(int.parse(periodSplit[1]));
        period = Period(startDate, endDate);
      }

      final value = snowLevelProbability.value;


      return SnowLevelProbability(period, value);
    }).toList();
  }

  List<SkyStatus> _parseSkyStatus(
      DateTime date, List<EstadoCielo> estadoCielo) {
    return estadoCielo.map((skyStatus) {
      Period period;

      if (skyStatus.periodo != null) {
        final periodSplit = skyStatus.periodo.split("-");

        final startDate = date.setHour(int.parse(periodSplit.first));
        final endDate = date.setHour(int.parse(periodSplit[1]));
        period = Period(startDate, endDate);
      }

      final value = skyStatus.value;


      return SkyStatus(period, value);
    }).toList();
  }

  List<DailyWind> _parseDailyWind(DateTime date, List<Viento> viento) {
    return viento.map((wind) {
      Period period;

      if (wind.periodo != null) {
        final periodSplit = wind.periodo.split("-");

        final startDate = date.setHour(int.parse(periodSplit.first));
        final endDate = date.setHour(int.parse(periodSplit[1]));
        period = Period(startDate, endDate);
      }

      final value = wind.velocidad.toString();
      final direction = wind.direccion;


      return DailyWind(period, value, direction);
    }).toList();
  }

  List<MaxWindGust> _parseMaxWindGust(DateTime date, List<RachaMax> rachaMax) {
    return rachaMax.map((maxWindGust) {
      Period period;

      if (maxWindGust.periodo != null) {
        final periodSplit = maxWindGust.periodo.split("-");

        final startDate = date.setHour(int.parse(periodSplit.first));
        final endDate = date.setHour(int.parse(periodSplit[1]));
        period = Period(startDate, endDate);
      }

      final value = maxWindGust.value;

      return MaxWindGust(period, value);
    }).toList();
  }

  Temperature _parseTemperature(DateTime date, Temperatura temperatura) {
    final max = temperatura.maxima.toString();
    final min = temperatura.minima.toString();

    final data = temperatura.dato.map((datoItem) {
      final value = datoItem.value.toString();
      final hour = date.setHour(datoItem.hora);

      return HourData(value, hour);
    }).toList();

    return Temperature(max, min, data);
  }

  ThermalSensation _parseThermalSensation(
      DateTime date, SensTermica sensTermica) {
    final max = sensTermica.maxima.toString();
    final min = sensTermica.minima.toString();

    final data = sensTermica.dato.map((datoItem) {
      final value = datoItem.value.toString();
      final hour = date.setHour(datoItem.hora);

      return HourData(value, hour);
    }).toList();

    return ThermalSensation(max, min, data);
  }

  RelativeHumidity _parseRelativeHumidity(
      DateTime date, HumedadRelativa humedadRelativa) {
    final max = humedadRelativa.maxima.toString();
    final min = humedadRelativa.minima.toString();

    final data = humedadRelativa.dato.map((datoItem) {
      final value = datoItem.value.toString();
      final hour = date.setHour(datoItem.hora);

      return HourData(value, hour);
    }).toList();

    return RelativeHumidity(max, min, data);
  }
}
