import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:teste_selecao/configs/routes/routes.dart';
import 'package:teste_selecao/features/login/screen/splash_screen.dart';
import 'package:teste_selecao/ui/Fontes.dart';

class IoasysSelecao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ioasys',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Fontes.montserrat,
      ),
      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,
      navigatorObservers: [
        SailorLoggingObserver(),
        Routes.sailor.navigationStackObserver,
      ],
      home: SplashScreen(),
    );
  }
}
