import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:teste_selecao/configs/routes/app/app_routes.dart';

class Routes {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      isLoggingEnabled: true,
      defaultTransitions: [
        SailorTransition.slide_from_bottom,
        SailorTransition.zoom_in,
      ],
      defaultTransitionCurve: Curves.decelerate,
      defaultTransitionDuration: Duration(milliseconds: 500),
    ),
  );

  static void createRoutes() {
    sailor.addRoutes(
      [
        ...AppRoutes.getRoutes(),
      ],
    );
  }
}
