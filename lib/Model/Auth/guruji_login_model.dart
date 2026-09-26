class GurujiLoginModel {
  String? phone;
  String? password;

  GurujiLoginModel({this.phone, this.password});

  GurujiLoginModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
