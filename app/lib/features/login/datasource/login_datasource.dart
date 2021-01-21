import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/configs/utils/Endpoint.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';

abstract class ILoginDataSource {
  Future<ApiResult> realizarLogin({Map<String, dynamic> body});
}

class LoginDataSource implements ILoginDataSource {
  final RequestApiProvider _requestApiProvider;

  LoginDataSource({
    @required apiProvider,
  }) : _requestApiProvider = apiProvider;

  @override
  Future<ApiResult> realizarLogin({Map<String, dynamic> body}) async {
    return await _requestApiProvider.execute(
      Endpoint(
        data: body,
        method: EndPointMethod.post,
        url: '/v1/users/auth/sign_in',
      ),
    );
  }
}
