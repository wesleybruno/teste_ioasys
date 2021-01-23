import 'package:flutter/material.dart';
import 'package:teste_selecao/configs/ui/Cores.dart';
import 'package:teste_selecao/configs/ui/DimensoesTela.dart';
import 'package:teste_selecao/configs/ui/Fontes.dart';
import 'package:teste_selecao/configs/ui/Strings.dart';
import 'package:teste_selecao/features/home/models/enterprise_model.dart';
import 'package:teste_selecao/widgets/cached_image/cached_image.dart';

enum TipoEmpresa {
  Software,
  IoT,
  Health,
  Education,
  Industry,
  Marketplace,
  Construction,
  Fintech,
  HR_Tech,
  Biotechnology,
  Default
}

class ItemEmpresaFactory {
  Color _getTipoEmpresa(String tipoEmpresa) {
    switch (tipoEmpresa) {
      case 'Biotechnology':
        return _getColorType(TipoEmpresa.Biotechnology);
        break;
      case 'Health':
        return _getColorType(TipoEmpresa.Health);
      default:
        return _getColorType(TipoEmpresa.Default);
    }
  }

  Color _getColorType(TipoEmpresa tipoEmpresa) {
    switch (tipoEmpresa) {
      case TipoEmpresa.Software:
        return Cores.ruby;
        break;
      case TipoEmpresa.Health:
        return Cores.chocolate;
        break;
      case TipoEmpresa.Biotechnology:
        return Cores.vermelhorErro;
        break;
      default:
        return Cores.ruby;
    }
  }

  Widget buildItemEnterprise(Enterprises enterprise) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.all(12.w),
        height: 100.h,
        color: _getTipoEmpresa(enterprise.enterpriseType?.enterpriseTypeName),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80.h,
              width: 80.w,
              child: CachedImage(
                  imageUrl:
                      'https://empresas.ioasys.com.br/${enterprise.photo}'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${enterprise.city} - ${enterprise.country}'),
                Text(enterprise.enterpriseType.enterpriseTypeName),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildText(int totaisEncontrados) {
    return Container(
      margin: EdgeInsets.only(top: 36.h, left: 16.w),
      child: Text(
        Strings.totaisEncontrados(totaisEncontrados),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 14.ssp,
          fontFamily: Fontes.montserrat,
          color: Cores.cinza[200],
        ),
      ),
    );
  }

  Widget buildItens(List<Enterprises> enterprises) {
    List<Widget> lista = [_buildText(enterprises.length)];
    for (var enterprise in enterprises) {
      final widgetEnterprise = buildItemEnterprise(enterprise);
      lista.add(widgetEnterprise);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lista,
    );
  }
}
