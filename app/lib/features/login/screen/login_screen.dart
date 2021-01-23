import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_selecao/configs/routes/app/i_app_navigator.dart';
import 'package:teste_selecao/configs/ui/Cores.dart';
import 'package:teste_selecao/configs/ui/DimensoesTela.dart';
import 'package:teste_selecao/configs/ui/Fontes.dart';
import 'package:teste_selecao/configs/ui/Icones.dart';
import 'package:teste_selecao/configs/ui/Strings.dart';
import 'package:teste_selecao/features/login/screen/bloc/login_cubit.dart';
import 'package:teste_selecao/injection_container.dart';
import 'package:teste_selecao/widgets/botao_principal/botao_principal.dart';
import 'package:teste_selecao/widgets/campo_form/campo_form.dart';
import 'package:teste_selecao/widgets/error_widgets/sem_internet_widget.dart';
import 'package:teste_selecao/widgets/loading_blur_screen/loading_blur_screen.dart';
import 'package:teste_selecao/widgets/top_clipper/top_clipper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerSenha;

  @override
  void initState() {
    _controllerEmail = TextEditingController();
    _controllerSenha = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerEmail.clear();
    _controllerSenha.clear();
    _controllerEmail.dispose();
    _controllerSenha.dispose();
    super.dispose();
  }

  void _aoApertarLogin(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
    BlocProvider.of<LoginScreenCubit>(context).realizarLogin(
      _controllerEmail.text,
      _controllerSenha.text,
    );
  }

  _irParaHome() {
    dependencia<IAppNavigator>().irParaHome(podeVoltar: false);
  }

  bool _esconderSenha = true;
  _aoApertarIconeOlho() {
    _esconderSenha = !_esconderSenha;
    setState(() {});
  }

  _validarDados(BuildContext context) {
    BlocProvider.of<LoginScreenCubit>(context).validarDados(
      _controllerEmail.text,
      _controllerSenha.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => dependencia<LoginScreenCubit>(),
      child: BlocConsumer<LoginScreenCubit, LoginState>(
        listener: (context, state) {
          if (state is CredenciaisValidasState) {
            _irParaHome();
          }
        },
        builder: (context, state) {
          if (state is NoInternet)
            return SemInternetWidget(
              aoApertarTentarNovamente: () => _aoApertarLogin(context),
            );

          return LoadingBlurScreen(
            enabled: state is LoadingState,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.translucent,
              child: SingleChildScrollView(
                child: Container(
                  height: DimensoesTela.altura,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TopClipper(
                        texto: Strings.textoTopClipper,
                      ),
                      _buildCampoForm(
                        Strings.email,
                        _controllerEmail,
                        state is CredenciaisInvalidasState,
                        false,
                        context,
                        state is CredenciaisInvalidasState,
                        icone: IconesAplicacao.iconeErro,
                        aoApertarIcone: null,
                      ),
                      _buildCampoForm(
                        Strings.senha,
                        _controllerSenha,
                        state is CredenciaisInvalidasState,
                        _esconderSenha,
                        context,
                        true,
                        icone: state is CredenciaisInvalidasState
                            ? IconesAplicacao.iconeErro
                            : IconesAplicacao.iconeOlho,
                        aoApertarIcone: () => _aoApertarIconeOlho(),
                      ),
                      if (state is CredenciaisInvalidasState)
                        _buildMessagemCredenciaisInvalidas(),
                      _buildButton(state is DadosValidoState, context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildCampoForm(
    String texto,
    TextEditingController controller,
    bool possuiErro,
    bool esconderCaracteres,
    BuildContext context,
    bool exibirIcone, {
    String icone,
    Function aoApertarIcone,
  }) {
    return CampoForm(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 5.h,
      ),
      titulo: texto,
      keyboardType: TextInputType.emailAddress,
      obscureText: esconderCaracteres,
      fillColor: Cores.cinza[100],
      controller: controller,
      possuiErro: possuiErro,
      borderColor: Cores.vermelhorErro,
      suffixIcon: exibirIcone
          ? _buildIcon(
              icone ?? IconesAplicacao.iconeErro,
              aoApertar: aoApertarIcone,
            )
          : null,
      onChange: (_) => _validarDados(context),
    );
  }

  _buildMessagemCredenciaisInvalidas() {
    return Container(
      margin: EdgeInsets.only(
        right: 20.w,
      ),
      child: Text(
        Strings.credenciaisInvalidas,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 12.ssp,
          color: Cores.vermelhorErro,
        ),
      ),
    );
  }

  _buildButton(bool habilitar, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30.w,
        right: 30.w,
        top: 30.h,
        bottom: 80.h,
      ),
      child: BotaoPrincipal(
        aoClicar: () => _aoApertarLogin(context),
        habilitar: habilitar,
        corDesabilitado: Cores.cinza[200],
        texto: Strings.entrar,
        textStyle: TextStyle(
          fontSize: 16.ssp,
          fontWeight: Fontes.semiBold,
          color: Cores.branco,
        ),
        altura: 48.h,
        raioBorda: 8.w,
      ),
    );
  }

  _buildIcon(String icone, {Function aoApertar}) {
    return GestureDetector(
      onTap: aoApertar,
      child: Container(
        height: 25.h,
        width: 25.w,
        padding: EdgeInsets.all(12.w),
        child: Image.asset(icone),
      ),
    );
  }
}
