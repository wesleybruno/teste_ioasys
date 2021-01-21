import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/client/check_connectivty.dart';
import 'package:teste_selecao/configs/client/custom_dio.dart';
import 'package:teste_selecao/injection_container.dart';
import 'package:teste_selecao/utils/ApiResult.dart';
import 'package:teste_selecao/utils/Endpoint.dart';

class RequestApiProvider {
  CustomDio _customDio;

  RequestApiProvider({
    @required CustomDio customDio,
  }) : _customDio = customDio;

  Future<ApiResult> execute(Endpoint endpoint) async {
    try {
      final possuiInternet =
          await dependencia<LocalConnectivity>().checkConnection();
      if (!possuiInternet) return NoInternet();

      Response response;
      switch (endpoint.method) {
        case EndPointMethod.get:
          response = await getAsync(endpoint.url);
          break;
        case EndPointMethod.post:
          response = await post(endpoint.url, endpoint.data);
          break;
        case EndPointMethod.delete:
          response = await delete(endpoint.data, endpoint.data);
          break;
        case EndPointMethod.put:
          response = await put(endpoint.data, endpoint.data);
          break;
        case EndPointMethod.patch:
          response = await patch(endpoint.url, endpoint.data);
          break;
        default:
          return Failure(
            statusCode: null,
            message: 'Method Invalid',
          );
      }

      if (response.data != null && response.statusCode < 300) {
        return response.data is List
            ? Success(
                dataList: response.data,
                statusCode: response.statusCode,
              )
            : Success(
                data: response.data is Map ? response.data : {"resp": true},
                statusCode: response.statusCode,
              );
      }

      return Failure(
        statusCode: response.statusCode,
        message: response.statusMessage,
        data: response.data,
      );
    } catch (e) {
      return ApiError(
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
      );
    }
  }

  Future<Response> post(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.post(url, data: objeto);
  }

  Future<Response> put(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.put(url, data: objeto);
  }

  Future<Response> delete(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.delete(url, data: objeto);
  }

  Future<Response> patch(
    String url,
    dynamic objeto,
  ) async {
    return await _customDio.client.patch(url, data: objeto);
  }

  Future<Response> getAsync(
    String url,
  ) async {
    return await _customDio.client.get(url);
  }
}
