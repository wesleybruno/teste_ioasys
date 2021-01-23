import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:teste_selecao/configs/ui/Strings.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/features/perfil/model/perfil_empresa_model.dart';

class PerfilEmpresaDecodeHelper {
  Either<ApiResult, PerfilEmpresaModel> decodeEmpresas({
    @required ApiResult result,
  }) {
    try {
      if (result is Success) {
        final empresas = PerfilEmpresaModel.fromJson(result.data);
        return Right(empresas);
      }

      return Left(result);
    } catch (e) {
      result.message = Strings.erroAoDecodificar('EnterpriseByIdModel');
      return Left(result);
    }
  }
}
