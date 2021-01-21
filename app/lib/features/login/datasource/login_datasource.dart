import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/configs/utils/Endpoint.dart';
import 'package:teste_selecao/configs/utils/LocalStorage.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';

abstract class ILoginDataSource {
  Future<ApiResult> realizarLogin({Map<String, dynamic> body});
  void salvarCabecalhosLocal(String uuid, String client, String accessToken);
}

class LoginDataSource implements ILoginDataSource {
  final RequestApiProvider _requestApiProvider;
  final ILocalStorage _localStorage;

  LoginDataSource({
    @required apiProvider,
    @required localStorage,
  })  : _requestApiProvider = apiProvider,
        _localStorage = localStorage;

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

  @override
  salvarCabecalhosLocal(String uuid, String client, String accessToken) {
    this._localStorage.save('uuid', uuid);
    this._localStorage.save('client', client);
    this._localStorage.save('access-token', accessToken);
  }
}
