import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/configs/utils/Endpoint.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';

abstract class IEmpresasDataSource {
  Future<ApiResult> buscarEmpresas(String termoBusca);
}

class EmpresasDataSource implements IEmpresasDataSource {
  final RequestApiProvider _requestApiProvider;

  EmpresasDataSource({
    @required RequestApiProvider apiProvider,
  }) : _requestApiProvider = apiProvider;

  @override
  Future<ApiResult> buscarEmpresas(String termoBusca) async {
    return await _requestApiProvider.execute(
      Endpoint(
        data: null,
        method: EndPointMethod.get,
        url: '/v1/enterprises',
      ),
    );
  }
}
