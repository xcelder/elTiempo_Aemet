import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'package:aemet_radar/model/LocationOption.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

const String _townSpreadsheetPath = "assets/20codmun.xlsx";

Future<List<LocationOption>> provideLocations() async {
  final data = await rootBundle.load(_townSpreadsheetPath);
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  final spreadSheet = SpreadsheetDecoder.decodeBytes(bytes);

  final table = spreadSheet.tables[spreadSheet.tables.keys.first];

  final townList = List<LocationOption>();

  for (int i = 2; i < table.rows.length; i++) {
    final row = table.rows[i];

    final locationCode = "${row[1]}${row[2]}";
    final name = row[4].toString();

    townList.add(LocationOption(locationCode, name));
  }

  return townList;
}