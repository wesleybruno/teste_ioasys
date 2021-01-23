import 'package:get_it/get_it.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';
import 'package:teste_selecao/features/home/datasource/empresas_datasource.dart';
import 'package:teste_selecao/features/home/repository/empresas_decode_helper.dart';
import 'package:teste_selecao/features/home/repository/empresas_repository.dart';
import 'package:teste_selecao/features/home/screen/bloc/home_cubit.dart';
import 'package:teste_selecao/features/home/usecases/buscar_empresas_usecase.dart';
import 'package:teste_selecao/features/login/repository/login_repository.dart';
import 'package:teste_selecao/features/splash/screens/bloc/splash_cubit.dart';
import 'package:teste_selecao/features/splash/usecases/buscar_cabecalhos_local_usecase.dart';

class SplashInjection {
  void injetar(GetIt dependencia) {
    dependencia.registerLazySingleton<BuscarCabecalhosLocalLoginUseCase>(
      () => BuscarCabecalhosLocalLoginUseCase(
        loginRepository: dependencia<LoginRepository>(),
      ),
    );

    dependencia.registerFactory(
      () => SplashCubit(
        buscarCabecalhosLocalLoginUseCase:
            dependencia<BuscarCabecalhosLocalLoginUseCase>(),
      ),
    );
  }
}
