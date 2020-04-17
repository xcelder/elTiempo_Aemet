import 'dart:convert';

import 'package:aemet_radar/model/LocationOption.dart';
import 'package:aemet_radar/model/Province.dart';
import 'package:aemet_radar/model/SearchResult.dart';
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:aemet_radar/network/RetroClient.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:aemet_radar/values/Strings.dart';
import 'package:aemet_radar/utils/XORCipher.dart';
import 'package:aemet_radar/service/parser/RadarTimeLinesParser.dart' as RadarTimeLineParser;

class AemetRepository {
  final client = RetroClient();
  final environment = "aemet.es";

  Stream<List<RadarImage>> getRadarImagesFromNetwork(Province province) {
    String url = "/es/apps/radar";
    String param = "$radarPrefix${province.code}$radarSeparator$token";

//    String fullUrl =

//    final uri = Uri.http(environment, url, { radarParamName : encode(param) });
    final uri = Uri.parse("https://www.$environment$url?$radarParamName=${encode(param)}");
    final headers = { radarHeaderUserAgent : decode(userAgent) };

    return client.get(uri, headers: headers)
        .asStream()
        .map((response) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);

      final radarImages = RadarTimeLineParser.parse(jsonBody);

      radarImages.sort((first, second) => first.hour.compareTo(second.hour));

      return radarImages;
    });
  }

  Stream<SearchResult> searchLocation(String query) {
    final url =
        "/es/eltiempo/prediccion/municipios?modo=and&orden=n&tipo=sta&str=$query";
    final uri = Uri.http(environment, url);
    return client.get(uri).asStream().map((response) {
      final document = htmlParser.parse(response.body);
      final tabLinks = document
          .querySelector("ul[class=\"nav_pestanha\"]")
          ?.querySelectorAll("a");

      bool didFound = false;
      List<LocationOption> options = [];
      String locationCode;

      if (tabLinks != null && tabLinks.length > 0) {
        didFound = true;

        final firstLink = tabLinks[0].attributes["href"];
        final code = firstLink.substring(firstLink.lastIndexOf("/") + 1);

        locationCode = code;
      } else {
        final results =
            document.querySelectorAll("div[class=\"resultados_busqueda\"] li");

        if (results != null && results.length > 0) {
          results.forEach((result) {
            final link = result.querySelector("a");
            final href = link.attributes["href"];
            final info = result.querySelector("p").text;

            final code = href.substring(href.lastIndexOf("/") + 1);
            final name = link.text;
            final province = info
                .substring(info.indexOf(":") + 1,
                    info.indexOf("\n", info.indexOf(":")))
                .trim();

            options.add(LocationOption(code, name, province));
          });
        }
      }

      return SearchResult(didFound, options, locationCode);
    });
  }

  Stream<String> getWeekXmlLink(String locationCode) {
    final url = "/es/eltiempo/prediccion/municipios/$locationCode";

    final uri = Uri.http(environment, url);

    return client.get(uri).asStream().map((response) {
      final document = htmlParser.parse(response.body);
      final xmlLink = document.querySelector("div[class*=\"enlace_xml\"] a");

      if (xmlLink != null) {
        return xmlLink.attributes["href"];
      } else {
        return "";
      }
    });
  }

  Stream<String> getHourlyXmlLink(String locationCode) {
    final url = "/es/eltiempo/prediccion/municipios/horas/$locationCode";

    final uri = Uri.http(environment, url);

    return client.get(uri).asStream().map((response) {
      final document = htmlParser.parse(response.body);
      final xmlLink = document.querySelector("div[class*=\"enlace_xml\"] a");

      if (xmlLink != null) {
        return xmlLink.attributes["href"];
      } else {
        return "";
      }
    });
  }
}
