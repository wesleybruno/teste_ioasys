import 'package:get_it/get_it.dart';
import 'package:teste_selecao/configs/client/check_connectivty.dart';
import 'package:teste_selecao/configs/client/custom_dio.dart';
import 'package:teste_selecao/configs/routes/app/i_app_navigator.dart';
import 'package:teste_selecao/configs/routes/app/app_navigator.dart';
import 'package:teste_selecao/configs/utils/LocalStorage.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';
import 'package:teste_selecao/configs/utils/Validadores.dart';
import 'package:teste_selecao/features/home/datasource/empresas_datasource.dart';
import 'package:teste_selecao/features/home/repository/empresas_decode_helper.dart';
import 'package:teste_selecao/features/home/repository/empresas_repository.dart';
import 'package:teste_selecao/features/home/screen/bloc/home_cubit.dart';
import 'package:teste_selecao/features/home/usecases/buscar_empresas_usecase.dart';
import 'package:teste_selecao/features/login/datasource/login_datasource.dart';
import 'package:teste_selecao/features/login/repository/login_decode_helper.dart';
import 'package:teste_selecao/features/login/repository/login_repository.dart';
import 'package:teste_selecao/features/login/screen/bloc/login_cubit.dart';
import 'package:teste_selecao/features/login/usecases/gravar_cabecalhos_local_usecase.dart';
import 'package:teste_selecao/features/login/usecases/limpar_cabecalhos_usecase.dart';
import 'package:teste_selecao/features/login/usecases/realizar_login_usecase.dart';
import 'package:teste_selecao/features/perfil/injection_container.dart';
import 'package:teste_selecao/features/splash/screens/bloc/splash_cubit.dart';
import 'package:teste_selecao/features/splash/usecases/buscar_cabecalhos_local_usecase.dart';

final dependencia = GetIt.instance;

Future<void> init() async {
  dependencia.registerFactory(
    () => LocalConnectivity(),
  );

  dependencia.registerLazySingleton<ILoginDataSource>(
    () => LoginDataSource(
      apiProvider: dependencia<RequestApiProvider>(),
      localStorage: dependencia<ILocalStorage>(),
    ),
  );

  dependencia.registerLazySingleton<LoginDecodeHelper>(
    () => LoginDecodeHelper(),
  );

  dependencia.registerLazySingleton<LoginRepository>(
    () => LoginRepository(
      loginDecodeHelper: dependencia<LoginDecodeHelper>(),
      loginDataSource: dependencia<ILoginDataSource>(),
    ),
  );

  dependencia.registerLazySingleton<BuscarCabecalhosLocalLoginUseCase>(
    () => BuscarCabecalhosLocalLoginUseCase(
      loginRepository: dependencia<LoginRepository>(),
    ),
  );

  dependencia.registerFactory(
    () => CustomDio(),
  );

  dependencia.registerLazySingleton<ILocalStorage>(
    () => SharedPref(),
  );

  dependencia.registerFactory(
    () => RequestApiProvider(
      customDio: dependencia<CustomDio>(),
    ),
  );

  dependencia.registerSingleton<IAppNavigator>(
    AppNavigator(),
  );

  dependencia.registerLazySingleton<RealizarLoginUseCase>(
    () => RealizarLoginUseCase(
      loginRepository: dependencia<LoginRepository>(),
    ),
  );

  dependencia.registerLazySingleton<GravarCabecalhosLocalLoginUseCase>(
    () => GravarCabecalhosLocalLoginUseCase(
      loginRepository: dependencia<LoginRepository>(),
    ),
  );

  dependencia.registerLazySingleton<LimparCabecalhosLocalLoginUseCase>(
    () => LimparCabecalhosLocalLoginUseCase(
      loginRepository: dependencia<LoginRepository>(),
    ),
  );

  dependencia.registerFactory(
    () => SplashCubit(
      buscarCabecalhosLocalLoginUseCase:
          dependencia<BuscarCabecalhosLocalLoginUseCase>(),
    ),
  );

  dependencia.registerFactory(
    () => LoginScreenCubit(
      validadorEmail: ValidadorEmail(),
      validadorTamanho: ValidadorTamanho(),
      realizarLoginUseCase: dependencia<RealizarLoginUseCase>(),
      gravarCabecalhosLocalLoginUseCase:
          dependencia<GravarCabecalhosLocalLoginUseCase>(),
    ),
  );

  dependencia.registerLazySingleton<IEmpresasDataSource>(
    () => EmpresasDataSource(
      apiProvider: dependencia<RequestApiProvider>(),
    ),
  );

  dependencia.registerLazySingleton(
    () => EmpresasDecodeHelper(),
  );

  dependencia.registerLazySingleton(
    () => EmpresasRepository(
      empresasDataSource: dependencia<IEmpresasDataSource>(),
      empresasDecodeHelper: dependencia<EmpresasDecodeHelper>(),
    ),
  );

  dependencia.registerLazySingleton<BuscarEmpresasUseCase>(
    () => BuscarEmpresasUseCase(
      empresasRepository: dependencia<EmpresasRepository>(),
    ),
  );

  dependencia.registerFactory(
    () => HomeScreenCubit(
      buscarEmpresasUseCase: dependencia<BuscarEmpresasUseCase>(),
    ),
  );

  PerfilInjection()..injetar(dependencia);
}
