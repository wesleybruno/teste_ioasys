import 'package:teste_selecao/features/home/models/enterprise_model.dart';

class EmpresasModel {
  List<Enterprises> enterprises;

  EmpresasModel({this.enterprises});

  EmpresasModel.fromJson(Map<String, dynamic> json) {
    if (json['enterprises'] != null) {
      enterprises = List<Enterprises>();
      json['enterprises'].forEach((v) {
        enterprises.add(Enterprises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.enterprises != null) {
      data['enterprises'] = this.enterprises.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
