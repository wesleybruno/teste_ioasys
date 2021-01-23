import 'package:flutter/foundation.dart';

enum EndPointMethod { get, post, delete, put, patch }

class Endpoint {
  final String url;
  final EndPointMethod method;
  final dynamic data;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> queryParameters;

  Endpoint({
    @required this.url,
    @required this.method,
    @required this.data,
    this.queryParameters,
    this.headers,
  });

  Map<String, String> parseQueryParameters() {
    final Map<String, String> _queryParameters =
        queryParameters?.map((key, dynamic value) {
      if (value is List) {
        return MapEntry<String, String>(key, value.join(','));
      } else {
        return MapEntry<String, String>(key, '$value');
      }
    });

    return _queryParameters;
  }
}
