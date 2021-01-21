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

class EmailInvalidoState extends LoginState {
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
