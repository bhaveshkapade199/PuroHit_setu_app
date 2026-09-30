class GurujiLoginModel {
  String? phone;
  String? password;
  Authentication? authentication;

  GurujiLoginModel({this.phone, this.password, this.authentication});

  GurujiLoginModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];

    if (json['authentication'] != null) {
      authentication = Authentication.fromJson(json['authentication']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['phone'] = phone;
    data['password'] = password;
    data['authentication'] = authentication?.toJson();

    return data;
  }
}

class Authentication {
  String? accessToken;

  Authentication({this.accessToken});

  Authentication.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['access_token'] = accessToken;

    return data;
  }
}
