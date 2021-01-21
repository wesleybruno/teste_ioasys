import 'package:flutter/foundation.dart';

class IconesAplicacao {
  static String _comum({@required String nomeIcone}) {
    return 'assets/pictures/$nomeIcone.png';
  }

  static String get background => _comum(nomeIcone: 'background');
  static String get iconeErro => _comum(nomeIcone: 'icone_erro');
  static String get iconeLupa => _comum(nomeIcone: 'icone_lupa');
  static String get iconeOlho => _comum(nomeIcone: 'icone_olho');
  static String get iconeVoltar => _comum(nomeIcone: 'icone_voltar');
  static String get logoHome => _comum(nomeIcone: 'logo_home');
  static String get logo => _comum(nomeIcone: 'logo');
}
