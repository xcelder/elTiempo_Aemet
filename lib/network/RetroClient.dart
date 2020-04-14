import 'dart:async';
import 'dart:io';
import 'dart:convert';

class RetroClient {
  final HttpClient _client = HttpClient();

  Future<RetroResponse> get(Uri uri) async {
    final request = await _client.getUrl(uri);
    return _executeRequest(request);
  }

  Future<RetroResponse> _executeRequest(HttpClientRequest request) async {
    final completer = new Completer<RetroResponse>();
    final response = await request.close();

    StringBuffer responseBody = StringBuffer();

    response.listen(
      (data) {
        responseBody.write(String.fromCharCodes(data));
      },
      onDone: () {
        completer.complete(
            RetroResponse(response.statusCode, responseBody.toString()));
      },
    );

    return completer.future;
  }
}

class RetroResponse {
  final int statusCode;
  final String body;

  RetroResponse(this.statusCode, this.body);
}
