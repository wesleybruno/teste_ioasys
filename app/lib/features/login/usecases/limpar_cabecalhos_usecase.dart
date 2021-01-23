import 'package:flutter/foundation.dart';
import 'package:teste_selecao/features/login/repository/login_repository.dart';

class LimparCabecalhosLocalLoginUseCase {
  final LoginRepository _loginRepository;

  LimparCabecalhosLocalLoginUseCase({
    @required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  Future<void> call() async {
    return _loginRepository.limparCabecalhosLocal();
  }
}
