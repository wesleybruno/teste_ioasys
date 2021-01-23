import 'package:get_it/get_it.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';
import 'package:teste_selecao/features/perfil/datasource/perfil_empresa_datasource.dart';
import 'package:teste_selecao/features/perfil/repository/perfil_empresa_decode_helper.dart';
import 'package:teste_selecao/features/perfil/repository/perfil_empresa_repository.dart';
import 'package:teste_selecao/features/perfil/screens/bloc/perfil_empresa_cubit.dart';
import 'package:teste_selecao/features/perfil/usecases/perfil_empresa_usecase.dart';

class PerfilInjection {
  void injetar(GetIt dependencia) {
    dependencia.registerFactory(
      () => PerfilEmpresaCubit(
          perfilEmpresaUseCase: dependencia<PerfilEmpresaUseCase>()),
    );

    dependencia.registerFactory(
      () => PerfilEmpresaUseCase(
          perfilEmpresaRepository: dependencia<PerfilEmpresaRepository>()),
    );

    dependencia.registerFactory<PerfilEmpresaRepository>(
      () => PerfilEmpresaRepository(
          dataSource: dependencia<PerfilEmpresaDataSource>(),
          decodeHelper: dependencia<PerfilEmpresaDecodeHelper>()),
    );

    dependencia.registerFactory(
      () => PerfilEmpresaDecodeHelper(),
    );

    dependencia.registerFactory<PerfilEmpresaDataSource>(
      () => PerfilEmpresaDataSource(
          apiProvider: dependencia<RequestApiProvider>()),
    );
  }
}
