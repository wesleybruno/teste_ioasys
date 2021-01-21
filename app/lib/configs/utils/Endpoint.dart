import 'package:flutter/foundation.dart';

enum EndPointMethod { get, post, delete, put, patch }

class Endpoint {
  final String url;
  final EndPointMethod method;
  final dynamic data;

  Endpoint({
    @required this.url,
    @required this.method,
    @required this.data,
  });
}
