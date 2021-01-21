import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/configs/utils/Endpoint.dart';
import 'package:teste_selecao/configs/utils/LocalStorage.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';

abstract class ILoginDataSource {
  Future<ApiResult> realizarLogin({Map<String, dynamic> body});
  Future<void> salvarCabecalhosLocal(
      String uid, String client, String accessToken);
  Future<dynamic> buscarCabecalhoLocal(String chave);
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
  Future<void> salvarCabecalhosLocal(
      String uid, String client, String accessToken) async {
    await this._localStorage.save('uid', uid);
    await this._localStorage.save('client', client);
    await this._localStorage.save('access-token', accessToken);
  }

  @override
  Future<dynamic> buscarCabecalhoLocal(String chave) async {
    return await this._localStorage.read(chave);
  }
}
