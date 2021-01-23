import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/configs/utils/Validadores.dart';

import 'package:teste_selecao/features/login/models/usuario_model.dart';
import 'package:teste_selecao/features/login/screen/bloc/login_cubit.dart';
import 'package:teste_selecao/features/login/usecases/gravar_cabecalhos_local_usecase.dart';
import 'package:teste_selecao/features/login/usecases/realizar_login_usecase.dart';

class MockGravarCabecalhosLocalLoginUseCase extends Mock
    implements GravarCabecalhosLocalLoginUseCase {}

class MockRealizarLoginUseCase extends Mock implements RealizarLoginUseCase {}

class MockValidadorEmail extends Mock implements ValidadorEmail {}

class MockValidadorTamanho extends Mock implements ValidadorTamanho {}

void main() {
  LoginScreenCubit loginScreenCubit;
  MockGravarCabecalhosLocalLoginUseCase gravarCabecalhosLocalLoginUseCase;
  MockRealizarLoginUseCase realizarLoginUseCase;
  MockValidadorEmail validadorEmail;
  MockValidadorTamanho validadorTamanho;

  setUp(() {
    gravarCabecalhosLocalLoginUseCase = MockGravarCabecalhosLocalLoginUseCase();
    realizarLoginUseCase = MockRealizarLoginUseCase();
    validadorEmail = MockValidadorEmail();
    validadorTamanho = MockValidadorTamanho();
    loginScreenCubit = LoginScreenCubit(
      gravarCabecalhosLocalLoginUseCase: gravarCabecalhosLocalLoginUseCase,
      realizarLoginUseCase: realizarLoginUseCase,
      validadorEmail: validadorEmail,
      validadorTamanho: validadorTamanho,
    );
  });

  tearDown(
    () => loginScreenCubit.close(),
  );

  group('Cubit Login Screen: ', () {
    test(
      'Verificar estado inicial',
      () {
        expect(
          loginScreenCubit.state,
          LoginInicialState(),
        );
      },
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Sucesso - Realizar Login',
      build: () {
        when(
          realizarLoginUseCase.call('', ''),
        ).thenAnswer(
          (_) async => Right(UsuarioModel()),
        );
        return loginScreenCubit;
      },
      act: (bloc) async => loginScreenCubit.realizarLogin('', ''),
      expect: <LoginState>[
        LoadingState(),
        CredenciaisValidasState(),
      ],
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Falha - Realizar Login',
      build: () {
        when(
          realizarLoginUseCase.call('', ''),
        ).thenAnswer(
          (_) async => Left(ApiError(statusCode: 400)),
        );
        return loginScreenCubit;
      },
      act: (bloc) async => loginScreenCubit.realizarLogin('', ''),
      expect: <LoginState>[
        LoadingState(),
        CredenciaisInvalidasState(),
      ],
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Falha - Sem internet',
      build: () {
        when(
          realizarLoginUseCase.call('', ''),
        ).thenAnswer(
          (_) async => Left(ApiError(statusCode: null)),
        );
        return loginScreenCubit;
      },
      act: (bloc) async => loginScreenCubit.realizarLogin('', ''),
      expect: <LoginState>[
        LoadingState(),
        ApiReturnNoInternet(),
      ],
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Successo - Validar Dados',
      build: () {
        when(validadorEmail.isTextoValido(texto: anyNamed('texto'))).thenAnswer(
          (_) => true,
        );

        when(validadorTamanho.isTextoValido(texto: anyNamed('texto')))
            .thenAnswer(
          (_) => true,
        );
        return loginScreenCubit;
      },
      act: (bloc) async => loginScreenCubit.validarDados('', ''),
      expect: <LoginState>[
        DadosValidoState(),
      ],
    );

    blocTest<LoginScreenCubit, LoginState>(
      'Erro - Dados invalidos',
      build: () {
        when(validadorEmail.isTextoValido(texto: anyNamed('texto'))).thenAnswer(
          (_) => false,
        );

        when(validadorTamanho.isTextoValido(texto: anyNamed('texto')))
            .thenAnswer(
          (_) => false,
        );
        return loginScreenCubit;
      },
      act: (bloc) async => loginScreenCubit.validarDados('', ''),
      expect: <LoginState>[
        DadosInvalidoState(),
      ],
    );
  });
}
