import 'package:dio/dio.dart';

class ResquestInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    print(
        "REQUEST[${options?.method}] => PATH: ${options.baseUrl + options?.path} \n DATA: ${options.data}");
    return await _headers(options);
  }

  @override
  onResponse(Response response) {
    print(
        "RESPONSE[${response?.statusCode}] => PATH: ${response.request.baseUrl + response?.request?.path} \n RESULT: ${response.data}");
    return super.onResponse(response);
  }

  @override
  onError(DioError e) {
    print(
        "ERROR[${e?.response?.statusCode}] => PATH: ${e.request.baseUrl + e?.request?.path} \n DATA: ${e.response.data}");
    return super.onError(e);
  }

  Future<RequestOptions> _headers(RequestOptions options) async {
    options.headers["uid"] = "";
    options.headers["access-token"] = "";
    options.headers["client"] = "";
    return options;
  }
}
