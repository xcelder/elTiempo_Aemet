import 'package:aemet_radar/network/RetroClient.dart';
import 'package:aemet_radar/service/parser/OpenDataDynamicParser.dart';

class OpenDataDynamicRepository {
  final client = RetroClient();

  Future<T> retrieveParsedDataFromDynamicOpenData<T>(
    String url,
    OpenDataDynamicParser<T> parser,
  ) {
    final uri = Uri.parse(url);

    return client.get(uri).then((response) => parser.parse(response.body));
  }
}
