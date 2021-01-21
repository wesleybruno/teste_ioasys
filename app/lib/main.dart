import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_selecao/app.dart';
import 'package:teste_selecao/configs/routes/routes.dart';
import 'package:teste_selecao/injection_container.dart' as injection;
import 'package:teste_selecao/ui/Cores.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  Routes.createRoutes();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Cores.transparente),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(IoasysSelecao());
}
