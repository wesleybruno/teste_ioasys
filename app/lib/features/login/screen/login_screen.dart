import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_selecao/configs/routes/login/i_login_navigator.dart';
import 'package:teste_selecao/configs/ui/Cores.dart';
import 'package:teste_selecao/configs/ui/DimensoesTela.dart';
import 'package:teste_selecao/configs/ui/Fontes.dart';
import 'package:teste_selecao/configs/ui/Icones.dart';
import 'package:teste_selecao/configs/ui/Strings.dart';
import 'package:teste_selecao/features/login/screen/bloc/login_cubit.dart';
import 'package:teste_selecao/injection_container.dart';
import 'package:teste_selecao/widgets/botao_principal/botao_principal.dart';
import 'package:teste_selecao/widgets/campo_form/campo_form.dart';
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

  void aoApertarLogin(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
    BlocProvider.of<LoginCubit>(context).realizarLogin(
      _controllerEmail.text,
      _controllerSenha.text,
    );
  }

  void irParaHome() {
    dependencia<ILoginNavigator>().irParaHome(podeVoltar: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => dependencia<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is CredenciaisValidasState) {
            irParaHome();
          }
        },
        builder: (context, state) {
          return LoadingBlurScreen(
            enabled: state is LoadingState,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TopClipper(
                      texto: Strings.textoTopClipper,
                    ),
                    CampoForm(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 5.h,
                      ),
                      titulo: Strings.email,
                      keyboardType: TextInputType.emailAddress,
                      fillColor: Cores.cinza[100],
                      possuiErro: state is CredenciaisInvalidasState,
                      borderColor: Cores.vermelhorErro,
                      suffixIcon: null,
                    ),
                    CampoForm(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 5.h,
                      ),
                      titulo: Strings.senha,
                      fillColor: Cores.cinza[100],
                      obscureText: true,
                      possuiErro: state is CredenciaisInvalidasState,
                      borderColor: Cores.vermelhorErro,
                      suffixIcon: Container(
                        height: 25.h,
                        width: 25.w,
                        padding: EdgeInsets.all(12.w),
                        child: Image.asset(IconesAplicacao.iconeOlho),
                      ),
                    ),
                    if (state is CredenciaisInvalidasState)
                      Container(
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
                      ),
                    Padding(
                      padding: EdgeInsets.all(30.w),
                      child: BotaoPrincipal(
                        aoClicar: () => aoApertarLogin(context),
                        texto: Strings.entrar,
                        textStyle: TextStyle(
                          fontSize: 16.ssp,
                          fontWeight: Fontes.semiBold,
                          color: Cores.branco,
                        ),
                        altura: 48.h,
                        raioBorda: 8.w,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
