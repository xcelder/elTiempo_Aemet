import 'dart:convert';

import 'package:aemet_radar/model/HourlyPrediction.dart';
import 'package:aemet_radar/service/parser/OpenDataDynamicParser.dart';
import 'package:aemet_radar/service/responses/HourlyPredictionResponse.dart';
import 'package:intl/intl.dart';
import 'package:aemet_radar/utils/DateTimeExtensions.dart';

class HourlyPredictionParser
    implements OpenDataDynamicParser<HourlyPrediction> {
  @override
  HourlyPrediction parse(String data) {
    final Map<String, dynamic> jsonBody =
        (jsonDecode(data) as List<dynamic>).first;
    final hourlyPredictionResponse =
        HourlyPredictionResponse.fromJson(jsonBody);

    return _fromResponse(hourlyPredictionResponse);
  }

  HourlyPrediction _fromResponse(HourlyPredictionResponse response) {
    final town = response.nombre;
    final province = response.provincia;
    final days = _parseDays(response);

    return HourlyPrediction(town, province, days);
  }

  List<HourlyPredictionDay> _parseDays(HourlyPredictionResponse response) {
    return response.prediccion.dia.map((day) => _parseDay(day)).toList();
  }

  HourlyPredictionDay _parseDay(Dia day) {
    final dateFormat = DateFormat("yyyy-MM-DDTHH:mm:ss");
    final hourFormat = DateFormat("HH:mm");

    final date = dateFormat.parse(day.fecha);
    final predictionHours = _parseHours(day);
    final predictionHourRangess = _parseHourRanges(day);
    final orto = hourFormat.parse(day.orto);
    final ocaso = hourFormat.parse(day.ocaso);

    return HourlyPredictionDay(
        date, predictionHours, predictionHourRangess, orto, ocaso);
  }

  List<PredictionHour> _parseHours(Dia day) {
    assert(day.everyDataHasSamePeriods());

    List<VientoAndRachaMax> groupedWinds = _groupByHour(day.vientoAndRachaMax);
    groupedWinds.sort((a, b) => a.periodo.compareTo(b.periodo));

    List<PredictionHour> hours = List<PredictionHour>();

    final dayTime = DateFormat("yyyy-MM-DDTHH:mm:ss").parse(day.fecha);

    for (int i = 0; i < groupedWinds.length; i++) {
      final wind = groupedWinds[i];

      final hour = dayTime.setHour(int.parse(wind.periodo));

      final temperature =
          day.temperatura.firstWhere((item) => item.periodo == wind.periodo);
      final thermalSensations =
          day.sensTermica.firstWhere((item) => item.periodo == wind.periodo);
      final relativeHumidity = day.humedadRelativa
          .firstWhere((item) => item.periodo == wind.periodo);
      final rainfall =
          day.precipitacion.firstWhere((item) => item.periodo == wind.periodo);
      final snow = day.nieve.firstWhere((item) => item.periodo == wind.periodo);
      final skyStatus =
          day.estadoCielo.firstWhere((item) => item.periodo == wind.periodo);

      final predictionHour = PredictionHour(
        hour,
        temperature.value,
        thermalSensations.value,
        relativeHumidity.value,
        wind.asWind(),
        rainfall.value,
        snow.value,
        skyStatus.value,
      );

      hours.add(predictionHour);
    }

    return hours;
  }

  List<PredictionHourRange> _parseHourRanges(Dia day) {
    assert(day.everyDataHasSameRangePeriods());

    List<PredictionHourRange> predictionHourRanges = List();

    final dayTime = DateFormat("yyyy-MM-DDTHH:mm:ss").parse(day.fecha);

    for (int i = 0; i < day.probPrecipitacion.length; i++) {
      final rainProbability = day.probPrecipitacion[i];
      final range = rainProbability.periodo;

      final stormProbability =
          day.probTormenta.firstWhere((item) => item.periodo == range);
      final snowProbability =
          day.probNieve.firstWhere((item) => item.periodo == range);

      final startTime = dayTime.setHour(int.parse(range.substring(0, 2)));
      final endTime = dayTime.setHour(int.parse(range.substring(2)));

      final predictionHourRange = PredictionHourRange(
        startTime,
        endTime,
        rainProbability.value,
        stormProbability.value,
        snowProbability.value,
      );

      predictionHourRanges.add(predictionHourRange);
    }

    return predictionHourRanges;
  }

  List<VientoAndRachaMax> _groupByHour(List<VientoAndRachaMax> winds) {
    List<VientoAndRachaMax> grouped = List<VientoAndRachaMax>();

    winds.forEach((wind) {
      if (grouped.any((item) => item.periodo == wind.periodo)) {
        final groupedItem =
            grouped.firstWhere((item) => item.periodo == wind.periodo);

        groupedItem.populateWith(wind);
      } else {
        grouped.add(wind);
      }
    });

    return grouped;
  }
}

extension WindParser on VientoAndRachaMax {
  Wind asWind() {
    return Wind(this.direccion.first, this.velocidad.first, this.value);
  }

  void populateWith(VientoAndRachaMax item) {
    this.direccion = this.direccion ?? item.direccion;
    this.velocidad = this.velocidad ?? item.velocidad;
    this.value = this.value ?? item.value;
  }
}

extension DayAssertion on Dia {
  bool everyDataHasSamePeriods() {
    return this.temperatura.length == this.sensTermica.length &&
        this.sensTermica.length == this.humedadRelativa.length &&
        this.humedadRelativa.length == this.estadoCielo.length &&
        this.estadoCielo.length == (this.vientoAndRachaMax.length / 2);
  }

  bool everyDataHasSameRangePeriods() {
    return this.probPrecipitacion.length == this.probTormenta.length &&
        this.probTormenta.length == this.probNieve.length;
  }
}
