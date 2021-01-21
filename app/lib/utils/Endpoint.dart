import 'package:flutter/foundation.dart';

enum EndPointMethod { get, post, delete, put, patch }

class Endpoint {
  final String url;
  final String mockName;
  final EndPointMethod method;
  final dynamic data;

  Endpoint({
    @required this.url,
    @required this.mockName,
    @required this.method,
    @required this.data,
  });
}
