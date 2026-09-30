class VerifyOTPModel {
  bool? success;
  String? message;
  VerifyOTPData? data;

  VerifyOTPModel({this.success, this.message, this.data});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = (json['data'] != null && json['data'] is Map<String, dynamic>)
        ? VerifyOTPData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VerifyOTPData {
  String? verificationToken;
  String? verificationUid;
  String? channel;
  String? destination;
  String? purpose;
  bool? verified;
  int? expiresIn;

  VerifyOTPData({
    this.verificationToken,
    this.verificationUid,
    this.channel,
    this.destination,
    this.purpose,
    this.verified,
    this.expiresIn,
  });

  VerifyOTPData.fromJson(Map<String, dynamic> json) {
    verificationToken = json['verification_token'];
    verificationUid = json['verification_uid'];
    channel = json['channel'];
    destination = json['destination'];
    purpose = json['purpose'];
    verified = json['verified'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verification_token'] = verificationToken;
    data['verification_uid'] = verificationUid;
    data['channel'] = channel;
    data['destination'] = destination;
    data['purpose'] = purpose;
    data['verified'] = verified;
    data['expires_in'] = expiresIn;
    return data;
  }
}
