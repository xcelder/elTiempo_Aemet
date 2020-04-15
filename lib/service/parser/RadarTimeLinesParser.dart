
import 'package:aemet_radar/model/RadarImage.dart';
import 'package:aemet_radar/service/responses/RadarTimeLinesResponse.dart';
import 'package:intl/intl.dart';

List<RadarImage> parse(Map<String, dynamic> json) {
  final response = RadarTimeLinesResponse.fromJson(json);

  if (response.imagenes.length != response.fechas.length) {
    throw Exception("images and dates has different length");
  }

  return List<RadarImage>.generate(response.imagenes.length, (i) {
    final originalFormat = DateFormat("DD/MM/yyyy HH:mm");
    
    final dateTime = originalFormat.parse(response.fechas[i]);

    final imageUrl = "https://www.aemet.es${response.imagenes[i]}";

    return RadarImage(imageUrl, dateTime);
  });
}