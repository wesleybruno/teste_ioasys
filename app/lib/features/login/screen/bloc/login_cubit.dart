import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_selecao/configs/utils/Validadores.dart';
import 'package:teste_selecao/features/login/repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository _loginRepository;
  final ValidadorEmail _validadorEmail;

  LoginCubit({
    @required LoginRepository loginRepository,
    @required ValidadorEmail validadorEmail,
  })  : _loginRepository = loginRepository,
        _validadorEmail = validadorEmail,
        super(
          LoginInicialState(),
        );

  void validarLogin(String email) {
    final resultValidarEmail = _validadorEmail.isTextoValido(texto: email);
    if (!resultValidarEmail) {
      emit(EmailInvalidoState());
    }
  }

  void realizarLogin(String email, String password) async {
    emit(LoadingState());
    final result = await _loginRepository.realizarLogin(email, password);
    result.fold(
      (error) => emit(CredenciaisInvalidasState(
        mensagem: error.message,
      )),
      (sucesso) => emit(CredenciaisValidasState()),
    );
  }
}
