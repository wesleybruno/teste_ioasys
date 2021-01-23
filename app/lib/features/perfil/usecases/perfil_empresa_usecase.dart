import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/features/perfil/model/perfil_empresa_model.dart';
import 'package:teste_selecao/features/perfil/repository/perfil_empresa_repository.dart';

class PerfilEmpresaUseCase {
  PerfilEmpresaRepository _perfilEmpresaRepository;
  PerfilEmpresaUseCase(
      {@required PerfilEmpresaRepository perfilEmpresaRepository})
      : _perfilEmpresaRepository = perfilEmpresaRepository;

  Future<Either<ApiResult, PerfilEmpresaModel>> call(int empresaId) async {
    return _perfilEmpresaRepository.buscarById(empresaId);
  }
}
