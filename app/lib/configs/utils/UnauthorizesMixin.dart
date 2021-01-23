import 'package:teste_selecao/configs/routes/app/i_app_navigator.dart';
import 'package:teste_selecao/features/login/usecases/limpar_cabecalhos_usecase.dart';
import 'package:teste_selecao/injection_container.dart';

mixin UnauthorizedMixin {
  void redirecionarLogin() {
    final limparCabecalhosLocalLoginUseCase =
        dependencia<LimparCabecalhosLocalLoginUseCase>();
    limparCabecalhosLocalLoginUseCase.call();
    dependencia<IAppNavigator>().irParaLogin(podeVoltar: false);
  }
}
