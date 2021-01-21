import 'package:flutter/material.dart';
import 'package:teste_selecao/configs/ui/Strings.dart';
import 'package:teste_selecao/widgets/error_widgets/generic_error_widget.dart';

class SemInternetWidget extends GenericErrorWidget {
  final Function aoApertarTentarNovamente;
  final Color corTexto;
  final Color corIcone;

  const SemInternetWidget({
    Key key,
    this.aoApertarTentarNovamente,
    this.corTexto,
    this.corIcone,
  }) : super(
          key: key,
          aoApertarTentarNovamente: aoApertarTentarNovamente,
          semanticText: Strings.dispositivoSemInternet,
          corIcone: corIcone,
          corTexto: corTexto,
          textoBotao: Strings.tentarNovamente,
          textoExplicativo: Strings.naoConseguimosVerificarInternet,
          textoPrincipal: Strings.offline,
        );
}
