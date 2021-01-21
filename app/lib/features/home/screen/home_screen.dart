import 'package:flutter/material.dart';
import 'package:teste_selecao/ui/Cores.dart';
import 'package:teste_selecao/ui/Icones.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Cores.preto,
      child: Center(
        child: Image.asset(IconesAplicacao.logo),
      ),
    );
  }
}
