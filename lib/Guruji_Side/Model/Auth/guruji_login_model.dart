class GurujiLoginModel {
  bool? success;
  String? message;
  String? phone;
  String? password;
  Authentication? authentication;
  Map<String, dynamic>? data;

  GurujiLoginModel({
    this.success,
    this.message,
    this.phone,
    this.password,
    this.authentication,
    this.data,
  });

  factory GurujiLoginModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? dataMap = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'])
        : null;

    Authentication? auth;
    if (json['authentication'] is Map) {
      auth = Authentication.fromJson(
        Map<String, dynamic>.from(json['authentication']),
      );
    } else if (dataMap != null && dataMap['authentication'] is Map) {
      auth = Authentication.fromJson(
        Map<String, dynamic>.from(dataMap['authentication']),
      );
    } else if (dataMap != null && dataMap['access_token'] != null) {
      auth = Authentication(accessToken: dataMap['access_token']?.toString());
    } else if (dataMap != null && dataMap['token'] != null) {
      auth = Authentication(accessToken: dataMap['token']?.toString());
    } else if (json['access_token'] != null) {
      auth = Authentication(accessToken: json['access_token']?.toString());
    } else if (json['token'] != null) {
      auth = Authentication(accessToken: json['token']?.toString());
    }

    return GurujiLoginModel(
      success: json['success'] == true,
      message: json['message']?.toString(),
      phone: json['phone']?.toString(),
      password: json['password']?.toString(),
      authentication: auth,
      data: dataMap,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['message'] = message;
    json['phone'] = phone;
    json['password'] = password;
    json['authentication'] = authentication?.toJson();
    json['data'] = data;
    return json;
  }
}

class Authentication {
  String? accessToken;

  Authentication({this.accessToken});

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return Authentication(
      accessToken:
          json['access_token']?.toString() ?? json['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    return data;
  }
}
