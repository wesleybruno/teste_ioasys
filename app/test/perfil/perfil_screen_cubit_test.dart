import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';

import 'package:teste_selecao/features/perfil/model/perfil_empresa_model.dart';
import 'package:teste_selecao/features/perfil/screens/bloc/perfil_empresa_cubit.dart';
import 'package:teste_selecao/features/perfil/usecases/perfil_empresa_usecase.dart';

class MockUseCase extends Mock implements PerfilEmpresaUseCase {}

void main() {
  PerfilEmpresaCubit perfilEmpresaCubit;
  MockUseCase mockUseCase;

  PerfilEmpresaModel tperfilEmpresaModel = PerfilEmpresaModel();

  setUp(() {
    mockUseCase = MockUseCase();
    perfilEmpresaCubit = PerfilEmpresaCubit(
      perfilEmpresaUseCase: mockUseCase,
    );
  });

  tearDown(
    () => perfilEmpresaCubit.close(),
  );

  group('Cubit Perfil Screen: ', () {
    test(
      'Verificar estado inicial',
      () {
        expect(
          perfilEmpresaCubit.state,
          PerfilEmpresaInicialState(),
        );
      },
    );

    blocTest<PerfilEmpresaCubit, PerfilEmpresaState>(
      'Sucesso - Buscar Dados',
      build: () {
        when(
          mockUseCase.call(1),
        ).thenAnswer(
          (_) async => Right(PerfilEmpresaModel()),
        );
        return perfilEmpresaCubit;
      },
      act: (bloc) async => perfilEmpresaCubit.buscarById(1),
      expect: <PerfilEmpresaState>[
        LoadingState(),
        DadosCarregadosState(enterpriseModel: tperfilEmpresaModel),
      ],
    );

    blocTest<PerfilEmpresaCubit, PerfilEmpresaState>(
      'Falha - Buscar Dados',
      build: () {
        when(
          mockUseCase.call(1),
        ).thenAnswer(
          (_) async => Left(ApiError(statusCode: 400)),
        );
        return perfilEmpresaCubit;
      },
      act: (bloc) async => perfilEmpresaCubit.buscarById(1),
      expect: <PerfilEmpresaState>[
        LoadingState(),
        ApiReturnError(),
      ],
    );

    blocTest<PerfilEmpresaCubit, PerfilEmpresaState>(
      'Falha - Sem internet',
      build: () {
        when(
          mockUseCase.call(1),
        ).thenAnswer(
          (_) async => Left(ApiError(statusCode: null)),
        );
        return perfilEmpresaCubit;
      },
      act: (bloc) async => perfilEmpresaCubit.buscarById(1),
      expect: <PerfilEmpresaState>[
        LoadingState(),
        ApiReturnNoInternet(),
      ],
    );
  });
}
