import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

class PefilEmpresaScreen extends StatefulWidget {
  @override
  _PefilEmpresaScreenState createState() => _PefilEmpresaScreenState();
}

class _PefilEmpresaScreenState extends State<PefilEmpresaScreen> {
  int empresaId;
  @override
  Widget build(BuildContext context) {
    empresaId = Sailor.param<int>(context, 'enterprise_id');
    return Center(
      child: Text('PerfilEmpresa $empresaId'),
    );
  }
}
