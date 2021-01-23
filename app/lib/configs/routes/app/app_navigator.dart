import 'package:sailor/sailor.dart';
import 'package:teste_selecao/configs/routes/app/i_app_navigator.dart';
import 'package:teste_selecao/configs/routes/app/app_routes.dart';
import 'package:teste_selecao/configs/routes/routes.dart';

class AppNavigator implements IAppNavigator {
  @override
  irParaHome({bool podeVoltar = false}) {
    Routes.sailor.navigate(
      AppRoutes.home,
      navigationType:
          podeVoltar ? NavigationType.push : NavigationType.popAndPushNamed,
    );
  }

  @override
  irParaLogin({bool podeVoltar = false}) {
    Routes.sailor.navigate(
      AppRoutes.login,
      navigationType:
          podeVoltar ? NavigationType.push : NavigationType.popAndPushNamed,
    );
  }

  @override
  irParaPerfil({bool podeVoltar = true}) {
    Routes.sailor.navigate(
      AppRoutes.perfil,
      navigationType:
          podeVoltar ? NavigationType.push : NavigationType.popAndPushNamed,
    );
  }
}