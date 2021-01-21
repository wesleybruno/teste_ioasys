import 'package:get_it/get_it.dart';
import 'package:teste_selecao/configs/client/check_connectivty.dart';
import 'package:teste_selecao/configs/client/custom_dio.dart';
import 'package:teste_selecao/configs/routes/login/i_login_navigator.dart';
import 'package:teste_selecao/configs/routes/login/login_navigator.dart';
import 'package:teste_selecao/configs/utils/LocalStorage.dart';
import 'package:teste_selecao/configs/utils/RequestApiProvider.dart';
import 'package:teste_selecao/configs/utils/Validadores.dart';
import 'package:teste_selecao/features/login/datasource/login_datasource.dart';
import 'package:teste_selecao/features/login/repository/login_decode_helper.dart';
import 'package:teste_selecao/features/login/repository/login_repository.dart';
import 'package:teste_selecao/features/login/screen/bloc/login_cubit.dart';
import 'package:teste_selecao/features/login/usecases/gravar_cabecalhos_local_usecase.dart';
import 'package:teste_selecao/features/login/usecases/realizar_login_usecase.dart';
import 'package:teste_selecao/features/splash/screens/bloc/splash_cubit.dart';
import 'package:teste_selecao/features/splash/usecases/buscar_cabecalhos_local_usecase.dart';

final dependencia = GetIt.instance;

Future<void> init() async {
  dependencia.registerFactory(
    () => LocalConnectivity(),
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

  dependencia.registerSingleton<ILoginNavigator>(
    LoginNavigator(),
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
      repositoriosDecodeHelper: dependencia<LoginDecodeHelper>(),
      repositorioDataSource: dependencia<ILoginDataSource>(),
    ),
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

  dependencia.registerFactory(
    () => LoginScreenCubit(
      validadorEmail: ValidadorEmail(),
      validadorTamanho: ValidadorTamanho(),
      realizarLoginUseCase: dependencia<RealizarLoginUseCase>(),
      gravarCabecalhosLocalLoginUseCase:
          dependencia<GravarCabecalhosLocalLoginUseCase>(),
    ),
  );
}
