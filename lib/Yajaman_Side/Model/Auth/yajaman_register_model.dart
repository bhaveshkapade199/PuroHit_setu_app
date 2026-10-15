class YajamanRegisterModel {
  String? name;
  String? phone;
  String? whatsappNumber;
  String? email;
  String? address;
  String? city;
  String? pincode;
  String? password;

  // OTP Verification parameters
  String? phoneVerificationUid;
  String? phoneVerificationToken;
  String? otpPurpose;

  YajamanRegisterModel({
    this.name,
    this.phone,
    this.whatsappNumber,
    this.email,
    this.address,
    this.city,
    this.pincode,
    this.password,
    this.phoneVerificationUid,
    this.phoneVerificationToken,
    this.otpPurpose,
  });

  YajamanRegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    password = json['password'];
    phoneVerificationUid = json['phone_verification_uid'];
    phoneVerificationToken = json['phone_verification_token'];
    otpPurpose = json['otp_purpose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['whatsapp_number'] = whatsappNumber;
    data['email'] = email;
    data['address'] = address;
    data['city'] = city;
    data['pincode'] = pincode;
    data['password'] = password;
    if (phoneVerificationUid != null) {
      data['phone_verification_uid'] = phoneVerificationUid;
    }
    if (phoneVerificationToken != null) {
      data['phone_verification_token'] = phoneVerificationToken;
    }
    if (otpPurpose != null) {
      data['otp_purpose'] = otpPurpose;
    }
    return data;
  }
}
