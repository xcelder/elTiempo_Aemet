import 'package:aemet_radar/model/LocationOption.dart';

class SearchResult {
  final bool didFound;
  final List<LocationOption> options;
  final String code;

  SearchResult(this.didFound, this.options, this.code);

}