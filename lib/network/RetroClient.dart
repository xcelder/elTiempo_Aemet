import 'dart:async';
import 'dart:io';

class RetroClient {
  final HttpClient _client = HttpClient();

  Future<RetroResponse> get(Uri uri, {Map<String, String> headers}) async {
    final request = _client.getUrl(uri);

    return _executeRequest(request, headers: headers);
  }

  Future<RetroResponse> _executeRequest(Future<HttpClientRequest> request,
      {Map<String, String> headers}) async {
    final completer = new Completer<RetroResponse>();

    final response = await request.then((request) {
      if (headers != null && headers.isNotEmpty) {
        headers.forEach((name, value) => request.headers.add(name, value));
      }

      return request.close();
    });

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
