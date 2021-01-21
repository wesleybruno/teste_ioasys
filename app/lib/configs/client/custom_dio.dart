import 'package:dio/dio.dart';
import 'package:teste_selecao/configs/client/request_Interceptor.dart';

class CustomDio {
  Dio client;

  CustomDio() {
    client = Dio();
    client.options.baseUrl = 'https://empresas.ioasys.com.br/api';
    client.interceptors.add(ResquestInterceptor());
    client.options.connectTimeout = 30000;
    client.options.receiveTimeout = 30000;
    client.options.validateStatus = validateStatus;
  }

  bool validateStatus(status) {
    return status < 500;
  }
}
