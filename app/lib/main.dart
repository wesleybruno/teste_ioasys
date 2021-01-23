import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_selecao/app.dart';
import 'package:teste_selecao/configs/routes/routes.dart';
import 'package:teste_selecao/configs/ui/Cores.dart';
import 'package:teste_selecao/injection_container.dart' as injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  Routes.createRoutes();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Cores.preto),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(IoasysSelecao());
}
