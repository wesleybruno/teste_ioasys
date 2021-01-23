import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_selecao/configs/utils/ApiResult.dart';
import 'package:teste_selecao/features/perfil/datasource/perfil_empresa_datasource.dart';
import 'package:teste_selecao/features/perfil/model/perfil_empresa_model.dart';
import 'package:teste_selecao/features/perfil/repository/perfil_empresa_decode_helper.dart';
import 'package:teste_selecao/features/perfil/repository/perfil_empresa_repository.dart';

class MockDatasource extends Mock implements IPerfilEmpresaDataSource {}

class MockDecodeHelper extends Mock implements PerfilEmpresaDecodeHelper {}

void main() {
  MockDatasource mockDataSource;
  PerfilEmpresaRepository perfilEmpresaRepository;
  MockDecodeHelper mockDecodeHelper;

  setUp(() {
    mockDataSource = MockDatasource();
    mockDecodeHelper = MockDecodeHelper();
    perfilEmpresaRepository = PerfilEmpresaRepository(
      dataSource: mockDataSource,
      decodeHelper: mockDecodeHelper,
    );
  });

  group('Perfil repository:', () {
    final tRetornoErro = ApiError(
      message: 'Erro na api',
      statusCode: 400,
    );

    final tRetornoSucesso = Success(dataList: [], statusCode: 200);

    final tNumber = 1;
    PerfilEmpresaModel perfilEmpresaModel = PerfilEmpresaModel();
    test(
      'Sucesso - Deve retornar um PerfilEmpresaModel',
      () async {
        when(mockDataSource.buscarById(tNumber))
            .thenAnswer((_) async => tRetornoSucesso);

        when(mockDecodeHelper.decodeEmpresas(result: tRetornoSucesso))
            .thenAnswer((_) => Right(perfilEmpresaModel));

        final result = await perfilEmpresaRepository.buscarById(tNumber);
        expect(result, isA<Right>());
        expect(result.fold((l) => l, (r) => r), isA<PerfilEmpresaModel>());
        verify(mockDataSource.buscarById(tNumber)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'Falha - Deve retornar erro da API quando houver falha',
      () async {
        when(mockDataSource.buscarById(tNumber))
            .thenAnswer((_) async => tRetornoErro);

        when(mockDecodeHelper.decodeEmpresas(result: tRetornoErro))
            .thenAnswer((_) => Left(tRetornoErro));

        final result = await perfilEmpresaRepository.buscarById(tNumber);

        expect(result, isA<Left>());
        expect(
          result,
          Left<ApiResult, PerfilEmpresaModel>(tRetornoErro),
        );
        verify(mockDataSource.buscarById(tNumber)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
