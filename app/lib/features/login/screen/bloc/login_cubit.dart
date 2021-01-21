import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_selecao/configs/utils/Validadores.dart';
import 'package:teste_selecao/features/login/repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository _loginRepository;
  final ValidadorEmail _validadorEmail;
  final ValidadorTamanho _validadorTamanho;

  LoginCubit({
    @required LoginRepository loginRepository,
    @required ValidadorEmail validadorEmail,
    @required ValidadorTamanho validadorTamanho,
  })  : _loginRepository = loginRepository,
        _validadorEmail = validadorEmail,
        _validadorTamanho = validadorTamanho,
        super(
          LoginInicialState(),
        );

  bool _validarLogin(String email) =>
      _validadorEmail.isTextoValido(texto: email);

  bool _validarSenha(String senha) =>
      _validadorTamanho.isTextoValido(texto: senha);

  void alterarVisibilidadeSenha(bool estaVisivel) =>
      !estaVisivel ? emit(SenhaVisivelState()) : emit(LoginInicialState());

  void validarDados(String email, String senha) {
    final loginValido = _validarLogin(email);
    final senhaValida = _validarSenha(senha);

    if (loginValido && senhaValida) {
      emit(DadosValidoState());
    } else {
      emit(DadosInvalidoState());
    }
  }

  void realizarLogin(String email, String password) async {
    emit(LoadingState());
    final result = await _loginRepository.realizarLogin(email, password);
    result.fold(
      (error) {
        if (error.statusCode == null) {
          return emit(NoInternet());
        }
        emit(CredenciaisInvalidasState(
          mensagem: error.message,
        ));
      },
      (sucesso) => emit(CredenciaisValidasState()),
    );
  }
}
