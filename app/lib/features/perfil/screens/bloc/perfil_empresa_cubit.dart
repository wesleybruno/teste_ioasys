import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_selecao/configs/utils/UnauthorizesMixin.dart';
import 'package:teste_selecao/features/home/models/empresas_model.dart';
import 'package:teste_selecao/features/perfil/model/perfil_empresa_model.dart';
import 'package:teste_selecao/features/perfil/usecases/perfil_empresa_usecase.dart';

part 'perfil_empresa_state.dart';

class PerfilEmpresaCubit extends Cubit<PerfilEmpresaState>
    with UnauthorizedMixin {
  PerfilEmpresaUseCase _perfilEmpresaUseCase;
  PerfilEmpresaCubit({
    @required PerfilEmpresaUseCase perfilEmpresaUseCase,
  })  : _perfilEmpresaUseCase = perfilEmpresaUseCase,
        super(
          PerfilEmpresaInicialState(),
        );

  Future<void> buscarById(int enterpriseId) async {
    emit(LoadingState());

    final result = await _perfilEmpresaUseCase(enterpriseId);

    result.fold((error) {
      if (error.statusCode == 401) {
        redirecionarLogin();
      }

      if (error.statusCode == null) {
        return emit(NoInternet());
      }
      emit(ApiError());
    }, (empresas) {
      return emit(DadosCarregadosState(enterpriseModel: empresas));
    });
  }
}
