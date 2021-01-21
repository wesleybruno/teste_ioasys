import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:teste_selecao/ui/Cores.dart';
import 'package:teste_selecao/ui/DimensoesTela.dart';
import 'package:teste_selecao/ui/Icones.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              IconesAplicacao.background,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20.w),
              child: Image.asset(
                IconesAplicacao.logoHome,
              ),
            ),
          )
        ],
      ),
    );
  }
}
