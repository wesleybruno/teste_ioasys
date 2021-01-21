import 'package:sailor/sailor.dart';
import 'package:teste_selecao/configs/routes/login/i_login_navigator.dart';
import 'package:teste_selecao/configs/routes/login/login_routes.dart';
import 'package:teste_selecao/configs/routes/routes.dart';

class LoginNavigator implements ILoginNavigator {
  @override
  irParaHome({bool podeVoltar = false}) {
    Routes.sailor.navigate(
      LoginRoutes.home,
      navigationType:
          podeVoltar ? NavigationType.push : NavigationType.popAndPushNamed,
    );
  }

  @override
  irParaLogin({bool podeVoltar = false}) {
    Routes.sailor.navigate(
      LoginRoutes.login,
      navigationType:
          podeVoltar ? NavigationType.push : NavigationType.popAndPushNamed,
    );
  }
}
