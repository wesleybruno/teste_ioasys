import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/features/login/datasource/login_datasource.dart';
import 'package:teste_selecao/features/login/models/login_model.dart';
import 'package:teste_selecao/features/login/models/usuario_model.dart';
import 'package:teste_selecao/features/login/repository/login_decode_helper.dart';

class LoginRepository {
  LoginRepository({
    @required repositorioDataSource,
    @required repositoriosDecodeHelper,
  })  : _dataSource = repositorioDataSource,
        _decodeHelper = repositoriosDecodeHelper;

  final ILoginDataSource _dataSource;
  final LoginDecodeHelper _decodeHelper;

  Future<Either<ApiResult, UsuarioModel>> realizarLogin(
    String email,
    String password,
  ) async {
    final loginModel = LoginModel(
      email: email,
      password: password,
    );

    final result = await this._dataSource.realizarLogin(
          body: loginModel.toJson(),
        );
    return _decodeHelper.decodeRepositorios(result: result);
  }

  void salvarCabecalhosLocal(
    String uuid,
    String client,
    String accessToken,
  ) async {
    this._dataSource.salvarCabecalhosLocal(uuid, client, accessToken);
  }
}
