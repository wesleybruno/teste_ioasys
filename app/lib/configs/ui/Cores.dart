import 'package:flutter/material.dart';

abstract class Cores {
  static final transparente = const Color(0x00000000);
  static final preto = const Color(0xFF000000);
  static final ruby = const Color(0xFFE01E69);
  static final claro = const Color(0xFFF2F2F2);
  static final branco = Color(0xFFFFFFFF);
  static final vermelhorErro = Color(0xFFE00000);

  static final chocolate = Color(0xFFD4621C);

  static const MaterialColor cinza = MaterialColor(
    0xFFF3F3F3,
    <int, Color>{
      50: Color(0xFFF5F5F5),
      100: Color(0xFFE5E5E5),
      200: Color(0xFFA1A1A1),
    },
  );
}
