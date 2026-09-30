class ForgetPasswordModel {
  bool? success;
  String? message;
  ForgetPasswordData? data;
  Guruji? guruji;
  Verification? verification;
  Api? api;
  dynamic errors;

  ForgetPasswordModel({
    this.success,
    this.message,
    this.data,
    this.guruji,
    this.verification,
    this.api,
    this.errors,
  });

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errors = json['errors'];
    api = json['api'] != null && json['api'] is Map<String, dynamic>
        ? Api.fromJson(json['api'])
        : null;

    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = ForgetPasswordData.fromJson(json['data']);
      guruji = data?.guruji;
      verification = data?.verification;
    }

    if (json['guruji'] != null && json['guruji'] is Map<String, dynamic>) {
      guruji = Guruji.fromJson(json['guruji']);
    }

    if (json['verification'] != null && json['verification'] is Map<String, dynamic>) {
      verification = Verification.fromJson(json['verification']);
    }

    if (data == null && (guruji != null || verification != null)) {
      data = ForgetPasswordData(guruji: guruji, verification: verification);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    json['message'] = message;
    if (errors != null) json['errors'] = errors;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    if (guruji != null) {
      json['guruji'] = guruji!.toJson();
    }
    if (verification != null) {
      json['verification'] = verification!.toJson();
    }
    if (api != null) {
      json['api'] = api!.toJson();
    }
    return json;
  }
}

class ForgetPasswordData {
  Guruji? guruji;
  Verification? verification;

  ForgetPasswordData({this.guruji, this.verification});

  ForgetPasswordData.fromJson(Map<String, dynamic> json) {
    guruji = json['guruji'] != null && json['guruji'] is Map<String, dynamic>
        ? Guruji.fromJson(json['guruji'])
        : null;
    verification = json['verification'] != null && json['verification'] is Map<String, dynamic>
        ? Verification.fromJson(json['verification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (guruji != null) {
      data['guruji'] = guruji!.toJson();
    }
    if (verification != null) {
      data['verification'] = verification!.toJson();
    }
    return data;
  }
}

class Guruji {
  int? id;
  String? gurujiUid;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phone;
  String? status;

  Guruji({
    this.id,
    this.gurujiUid,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phone,
    this.status,
  });

  Guruji.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gurujiUid = json['guruji_uid'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guruji_uid': gurujiUid,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'phone': phone,
      'status': status,
    };
  }
}

class Verification {
  String? channel;
  String? destination;
  String? verificationUid;
  String? purpose;
  bool? otpSent;

  Verification({
    this.channel,
    this.destination,
    this.verificationUid,
    this.purpose,
    this.otpSent,
  });

  Verification.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    destination = json['destination'];
    verificationUid = json['verification_uid'];
    purpose = json['purpose'];
    otpSent = json['otp_sent'];
  }

  Map<String, dynamic> toJson() {
    return {
      'channel': channel,
      'destination': destination,
      'verification_uid': verificationUid,
      'purpose': purpose,
      'otp_sent': otpSent,
    };
  }
}

class Api {
  String? name;
  String? version;
  String? endpoint;
  String? method;

  Api({this.name, this.version, this.endpoint, this.method});

  Api.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    version = json['version'];
    endpoint = json['endpoint'];
    method = json['method'];
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
