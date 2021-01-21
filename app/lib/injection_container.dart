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

  dependencia.registerFactory(
    () => LoginCubit(
      loginRepository: dependencia<LoginRepository>(),
      validadorEmail: ValidadorEmail(),
      validadorTamanho: ValidadorTamanho(),
    ),
  );
}
