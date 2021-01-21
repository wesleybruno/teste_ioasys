part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInicialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class SenhaVisivelState extends LoginState {
  @override
  List<Object> get props => [];
}

class DadosInvalidoState extends LoginState {
  @override
  List<Object> get props => [];
}

class DadosValidoState extends LoginState {
  @override
  List<Object> get props => [];
}

class CredenciaisInvalidasState extends LoginState {
  final String mensagem;
  CredenciaisInvalidasState({this.mensagem});
  @override
  List<Object> get props => [mensagem];
}

class CredenciaisValidasState extends LoginState {
  @override
  List<Object> get props => [];
}

class NoInternet extends LoginState {
  @override
  List<Object> get props => [];
}

class ApiError extends LoginState {
  @override
  List<Object> get props => [];
}
