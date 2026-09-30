class ResetPasswordModel {
  bool? success;
  String? message;
  List<dynamic>? errors;
  Api? api;
  Guruji? guruji;
  PasswordReset? passwordReset;

  ResetPasswordModel({
    this.success,
    this.message,
    this.errors,
    this.api,
    this.guruji,
    this.passwordReset,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      success: json['success'],
      message: json['message'],
      errors: json['errors'] != null
          ? List<dynamic>.from(json['errors'])
          : null,
      api: json['api'] != null ? Api.fromJson(json['api']) : null,
      guruji: json['guruji'] != null ? Guruji.fromJson(json['guruji']) : null,
      passwordReset: json['password_reset'] != null
          ? PasswordReset.fromJson(json['password_reset'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'errors': errors,
      'api': api?.toJson(),
      'guruji': guruji?.toJson(),
      'password_reset': passwordReset?.toJson(),
    };
  }
}

class Api {
  String? name;
  String? version;
  String? endpoint;
  String? method;

  Api({this.name, this.version, this.endpoint, this.method});

  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(
      name: json['name'],
      version: json['version'],
      endpoint: json['endpoint'],
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'version': version,
      'endpoint': endpoint,
      'method': method,
    };
  }
}

class Guruji {
  String? gurujiUid;
  String? phone;

  Guruji({this.gurujiUid, this.phone});

  factory Guruji.fromJson(Map<String, dynamic> json) {
    return Guruji(gurujiUid: json['guruji_uid'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'guruji_uid': gurujiUid, 'phone': phone};
  }
}

class PasswordReset {
  bool? success;
  bool? otpConsumed;

  PasswordReset({this.success, this.otpConsumed});

  factory PasswordReset.fromJson(Map<String, dynamic> json) {
    return PasswordReset(
      success: json['success'],
      otpConsumed: json['otp_consumed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'otp_consumed': otpConsumed};
  }
}
