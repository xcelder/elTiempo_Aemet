import 'package:aemet_radar/model/LocationOption.dart';
import 'package:aemet_radar/model/LocationWeather.dart';
import 'package:aemet_radar/model/SearchResult.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:aemet_radar/network/RetroClient.dart';

class AemetRepository {
  final client = RetroClient();
  final environment = "aemet.es";

  Stream<List<RadarImage>> getRadarImagesFromNetwork(String radarCode) {
    final url = radarCode == "ALL"
        ? "/es/eltiempo/observacion/radar?w=0"
        : "/es/eltiempo/observacion/radar?w=1&p=$radarCode";

    final uri = Uri.http(environment, url);
    return client.get(uri).asStream().map((response) {
      final List<RadarImage> radarImages = List<RadarImage>();

      final document = htmlParser.parse(response.body);
      final elements = document.querySelectorAll("div img[class=\"lazyOwl\"]");

      elements.forEach((element) {
        final src = element.attributes["data-src"];
        final alt = element.attributes["alt"];
        if (src != null && src.isNotEmpty) {
          RegExp regExp = new RegExp(
            r"([0-1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])",
            caseSensitive: false,
          );

          String hourString = regExp.stringMatch(alt).toString();
          final image = Image.network("http://$environment$src").image;

          radarImages.add(RadarImage(image, hourString));
        }
      });

      return radarImages;
    });
  }

  Stream<SearchResult> searchLocation(String query) {
    final url =
        "/es/eltiempo/prediccion/municipios?modo=and&orden=n&tipo=sta&str=$query";
    final uri = Uri.http(environment, url);
    return client.get(uri).asStream().map((response) {
      final document = htmlParser.parse(response.body);
      final tabLinks =
      document.querySelector("ul[class=\"nav_pestanha\"]")?.querySelectorAll("a");

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
