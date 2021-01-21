import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:teste_selecao/features/home/screen/home_screen.dart';
import 'package:teste_selecao/features/login/screen/login_screen.dart';
import 'package:teste_selecao/features/login/screen/splash_screen.dart';

abstract class LoginRoutes {
  static final splashScreen = '/splash';
  static final home = '/home';
  static final login = '/login';

  static getRoutes() {
    return [
      SailorRoute(
        name: LoginRoutes.splashScreen,
        builder: (context, args, params) => Scaffold(body: SplashScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      ),
      SailorRoute(
        name: LoginRoutes.login,
        builder: (context, args, params) => Scaffold(body: LoginScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      ),
      SailorRoute(
        name: LoginRoutes.home,
        builder: (context, args, params) => Scaffold(body: HomeScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      )
    ];
  }
}
