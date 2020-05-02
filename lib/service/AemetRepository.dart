import 'dart:convert';
import 'dart:math';

import 'package:aemet_radar/model/DailyPrediction.dart';
import 'package:aemet_radar/model/FullPrediction.dart';
import 'package:aemet_radar/model/HourlyPrediction.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:aemet_radar/network/RetroClient.dart';
import 'package:aemet_radar/service/OpenDataDynamicRepository.dart';
import 'package:aemet_radar/service/parser/DailyPredictionParser.dart';
import 'package:aemet_radar/service/parser/HourlyPredictionParser.dart';
import 'package:aemet_radar/service/responses/OpenDataBaseResponse.dart';
import 'package:aemet_radar/values/Strings.dart';
import 'package:aemet_radar/utils/XORCipher.dart';
import 'package:aemet_radar/service/parser/RadarTimeLinesParser.dart'
    as RadarTimeLineParser;

class AemetRepository {
  final _client = RetroClient();

  final _openDataDynamicRepository = OpenDataDynamicRepository();

  final _aemetBaseUrl = "aemet.es";
  final _aemetOpenDataBaseUrl = "opendata.aemet.es";

  Stream<List<RadarImage>> getRadarImagesFromNetwork(Province province) {
    String endpoint = "/es/apps/radar";
    String param = "$radarPrefix${province.code}$radarSeparator$token";

    final uri = Uri.parse(
        "https://www.$_aemetBaseUrl$endpoint?$radarParamName=${encode(param)}");
    final headers = {radarHeaderUserAgent: decode(userAgent)};

    return _client.get(uri, headers: headers).asStream().map((response) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);

      final radarImages = RadarTimeLineParser.parse(jsonBody);

      radarImages.sort((first, second) => first.hour.compareTo(second.hour));

      return radarImages;
    });
  }

  Stream<HourlyPrediction> getHourlyPredictionForLocation(String locationCode) {
    return _getHourlyPredictionForLocationFuture(locationCode).asStream();
  }

  Future<HourlyPrediction> _getHourlyPredictionForLocationFuture(
      String locationCode) {
    final endpoint =
        "/opendata/api/prediccion/especifica/municipio/horaria/$locationCode";

    final uri = Uri.https(_aemetOpenDataBaseUrl, endpoint);

    final headers = {apiKeyHeaderKey: openDataToken};

    return _client.get(uri, headers: headers).then((response) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      final openDataResponse = OpenDataBaseResponse.fromJson(jsonBody);

      if (openDataResponse.datos != null) {
        return _openDataDynamicRepository
            .retrieveParsedDataFromDynamicOpenData<HourlyPrediction>(
          openDataResponse.datos,
          HourlyPredictionParser(),
        );
      } else {
        throw Exception("Error retrieving data");
      }
    });
  }

  Stream<DailyPrediction> getDailyPredictionForLocation(String locationCode) {
    return _getDailyPredictionForLocationFuture(locationCode).asStream();
  }

  Future<DailyPrediction> _getDailyPredictionForLocationFuture(
      String locationCode) {
    final endpoint =
        "/opendata/api/prediccion/especifica/municipio/diaria/$locationCode";

    final uri = Uri.https(_aemetOpenDataBaseUrl, endpoint);

    final headers = {apiKeyHeaderKey: openDataToken};

    return _client.get(uri, headers: headers).then((response) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      final openDataResponse = OpenDataBaseResponse.fromJson(jsonBody);

      if (openDataResponse.datos != null) {
        return _openDataDynamicRepository
            .retrieveParsedDataFromDynamicOpenData<DailyPrediction>(
          openDataResponse.datos,
          DailyPredictionParser(),
        );
      } else {
        throw Exception("Error retrieving data");
      }
    });
  }

  Stream<FullPrediction> getFullPredictionForLocation(String locationCode) {
    return Future.wait([
      _getHourlyPredictionForLocationFuture(locationCode),
      _getDailyPredictionForLocationFuture(locationCode)
    ]).asStream().asyncMap((responses) {
      final HourlyPrediction hourlyPrediction =
          responses.firstWhere((item) => item is HourlyPrediction);
      final DailyPrediction dailyPrediction =
          responses.firstWhere((item) => item is DailyPrediction);

      final maxLength =
          max(hourlyPrediction.days.length, dailyPrediction.days.length);

      final town = hourlyPrediction.town;
      final province = hourlyPrediction.province;
      final List<FullPredictionDay> days = List();

      for (int i = 0; i < maxLength; i++) {
        if (i < hourlyPrediction.days.length) {
          final hourlyPredictionDay = hourlyPrediction.days[i];
          final dailyPredictionDay = dailyPrediction.days.firstWhere(
              (item) => item.date.isAtSameMomentAs(hourlyPredictionDay.date));

          final fullPredictionDay = _getFullPredictionOfHourlyAndDaily(
              dailyPredictionDay,
              hourlyPredictionDay: hourlyPredictionDay);

          days.add(fullPredictionDay);
        } else {
          final dailyPredictionDay = dailyPrediction.days[i];

          days.add(_getFullPredictionOfHourlyAndDaily(dailyPredictionDay));
        }
      }

      return FullPrediction(town, province, days);
    });
  }

  FullPredictionDay _getFullPredictionOfHourlyAndDaily(
    DailyPredictionDay dailyPredictionDay, {
    HourlyPredictionDay hourlyPredictionDay,
  }) {
    DateTime date = dailyPredictionDay.date;
    String uvMax = dailyPredictionDay.uvMax;
    List<RainProbability> rainProbability = dailyPredictionDay.rainProbability;
    List<SnowLevelProbability> snowLevelProbability =
        dailyPredictionDay.snowLevelProbability;
    List<SkyStatus> skyStatus = dailyPredictionDay.skyStatus;
    List<DailyWind> wind = dailyPredictionDay.wind;
    List<MaxWindGust> maxWindGust = dailyPredictionDay.maxWindGust;
    Temperature temperature = dailyPredictionDay.temperature;
    ThermalSensation thermalSensation = dailyPredictionDay.thermalSensation;
    RelativeHumidity relativeHumidity = dailyPredictionDay.relativeHumidity;

    List<PredictionHour> hours;
    List<PredictionHourRange> hourRanges;
    DateTime orto;
    DateTime ocaso;

    if (hourlyPredictionDay != null) {
      hours = hourlyPredictionDay.hours;
      hourRanges = hourlyPredictionDay.hourRanges;
      orto = hourlyPredictionDay.orto;
      ocaso = hourlyPredictionDay.ocaso;
    }

    return FullPredictionDay(
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
      hours: hours,
      hourRanges: hourRanges,
      orto: orto,
      ocaso: ocaso,
    );
  }
}
