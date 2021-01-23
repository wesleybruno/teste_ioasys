import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/configs/utils/Endpoint.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';

abstract class IPerfilEmpresaDataSource {
  Future<ApiResult> buscarById(int enterpriseId);
}

class PerfilEmpresaDataSource implements IPerfilEmpresaDataSource {
  final RequestApiProvider _requestApiProvider;

  PerfilEmpresaDataSource({
    @required RequestApiProvider apiProvider,
  }) : _requestApiProvider = apiProvider;

  @override
  Future<ApiResult> buscarById(int enterpriseId) async {
    return await _requestApiProvider.execute(
      Endpoint(
        data: null,
        method: EndPointMethod.get,
        url: '/v1/enterprises/$enterpriseId',
      ),
    );
  }
}
