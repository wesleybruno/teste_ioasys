import 'package:teste_selecao/features/home/models/enterprise_type_model.dart';

class Enterprises {
  int id;
  String emailEnterprise;
  String facebook;
  String twitter;
  String linkedin;
  String phone;
  bool ownEnterprise;
  String enterpriseName;
  String photo;
  String description;
  String city;
  String country;
  num value;
  num sharePrice;
  EnterpriseType enterpriseType;

  Enterprises(
      {this.id,
      this.emailEnterprise,
      this.facebook,
      this.twitter,
      this.linkedin,
      this.phone,
      this.ownEnterprise,
      this.enterpriseName,
      this.photo,
      this.description,
      this.city,
      this.country,
      this.value,
      this.sharePrice,
      this.enterpriseType});

  Enterprises.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emailEnterprise = json['email_enterprise'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    phone = json['phone'];
    ownEnterprise = json['own_enterprise'];
    enterpriseName = json['enterprise_name'];
    photo = json['photo'];
    description = json['description'];
    city = json['city'];
    country = json['country'];
    value = json['value'];
    sharePrice = json['share_price'];
    enterpriseType = json['enterprise_type'] != null
        ? EnterpriseType.fromJson(json['enterprise_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email_enterprise'] = this.emailEnterprise;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['phone'] = this.phone;
    data['own_enterprise'] = this.ownEnterprise;
    data['enterprise_name'] = this.enterpriseName;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['city'] = this.city;
    data['country'] = this.country;
    data['value'] = this.value;
    data['share_price'] = this.sharePrice;
    if (this.enterpriseType != null) {
      data['enterprise_type'] = this.enterpriseType.toJson();
    }
    return data;
  }
}
