import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:teste_selecao/features/home/screen/home_screen.dart';
import 'package:teste_selecao/features/login/screen/login_screen.dart';
import 'package:teste_selecao/features/perfil/screens/perfil_empresa_screen.dart';
import 'package:teste_selecao/features/splash/screens/splash_screen.dart';

abstract class AppRoutes {
  static final splashScreen = '/splash';
  static final home = '/home';
  static final login = '/login';
  static final perfil = '/perfil';

  static getRoutes() {
    return [
      SailorRoute(
        name: AppRoutes.splashScreen,
        builder: (context, args, params) => Scaffold(body: SplashScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      ),
      SailorRoute(
        name: AppRoutes.login,
        builder: (context, args, params) => Scaffold(body: LoginScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      ),
      SailorRoute(
        name: AppRoutes.home,
        builder: (context, args, params) => Scaffold(body: HomeScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      ),
      SailorRoute(
        name: AppRoutes.perfil,
        params: [
          SailorParam<int>(
            name: 'enterprise_id',
          ),
        ],
        builder: (context, args, params) => Scaffold(
          body: PefilEmpresaScreen(),
        ),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      )
    ];
  }
}
