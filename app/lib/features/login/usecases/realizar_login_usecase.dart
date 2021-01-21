import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/features/login/models/usuario_model.dart';
import 'package:teste_selecao/features/login/repository/login_repository.dart';

class RealizarLoginUseCase {
  final LoginRepository _loginRepository;

  RealizarLoginUseCase({
    @required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  Future<Either<ApiResult, UsuarioModel>> call(
    String email,
    String password,
  ) async {
    return await _loginRepository.realizarLogin(email, password);
  }
}
