import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:teste_selecao/configs/ui/Strings.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/features/login/models/dados_invalidos_model.dart';
import 'package:teste_selecao/features/login/models/usuario_model.dart';

class LoginDecodeHelper {
  Either<ApiResult, UsuarioModel> decodeRepositorios(
      {@required ApiResult result}) {
    try {
      if (result is Success) {
        return Right(UsuarioModel.fromJson(result.data));
      }

      if (result is Failure) {
        final dadosInvalidos = DadosInvalidosModel.fromJson(result.data);
        result.data = dadosInvalidos.toJson();
      }

      return Left(result);
    } catch (e) {
      result.message = Strings.erroAoDecodificar('LoginDecodeHelper');
      return Left(result);
    }
  }
}
