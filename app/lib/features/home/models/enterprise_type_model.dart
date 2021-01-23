class EnterpriseType {
  int id;
  String enterpriseTypeName;

  EnterpriseType({this.id, this.enterpriseTypeName});

  EnterpriseType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enterpriseTypeName = json['enterprise_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enterprise_type_name'] = this.enterpriseTypeName;
    return data;
  }
}
