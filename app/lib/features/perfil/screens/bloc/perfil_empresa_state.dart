part of 'perfil_empresa_cubit.dart';

abstract class PerfilEmpresaState extends Equatable {
  const PerfilEmpresaState();
}

class PerfilEmpresaInicialState extends PerfilEmpresaState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PerfilEmpresaState {
  @override
  List<Object> get props => [];
}

class DadosCarregadosState extends PerfilEmpresaState {
  final PerfilEmpresaModel enterpriseModel;

  DadosCarregadosState({@required this.enterpriseModel});

  @override
  List<Object> get props => [EmpresasModel];
}

class NoInternet extends PerfilEmpresaState {
  @override
  List<Object> get props => [];
}

class ApiError extends PerfilEmpresaState {
  @override
  List<Object> get props => [];
}
