class GurujiRegisterModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? phone;
  String? whatsappNumber;
  String? email;
  String? password;
  String? religion;
  String? sampraday;
  String? vedaShakha;

  // OTP Verification parameters
  String? phoneVerificationUid;
  String? emailVerificationUid;
  String? phoneVerificationToken;
  String? emailVerificationToken;
  String? otpPurpose;

  GurujiRegisterModel({
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.phone,
    this.whatsappNumber,
    this.email,
    this.password,
    this.religion,
    this.sampraday,
    this.vedaShakha,
    this.phoneVerificationUid,
    this.emailVerificationUid,
    this.phoneVerificationToken,
    this.emailVerificationToken,
    this.otpPurpose,
  });

  GurujiRegisterModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    phone = json['phone'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    password = json['password'];
    religion = json['religion'];
    sampraday = json['sampraday'];
    vedaShakha = json['veda_shakha'];
    phoneVerificationUid = json['phone_verification_uid'];
    emailVerificationUid = json['email_verification_uid'];
    phoneVerificationToken = json['phone_verification_token'];
    emailVerificationToken = json['email_verification_token'];
    otpPurpose = json['otp_purpose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['phone'] = phone;
    data['whatsapp_number'] = whatsappNumber;
    data['email'] = email;
    data['password'] = password;
    data['religion'] = religion;
    data['sampraday'] = sampraday;
    data['veda_shakha'] = vedaShakha;
    if (phoneVerificationUid != null) {
      data['phone_verification_uid'] = phoneVerificationUid;
    }
    if (emailVerificationUid != null) {
      data['email_verification_uid'] = emailVerificationUid;
    }
    if (phoneVerificationToken != null) {
      data['phone_verification_token'] = phoneVerificationToken;
    }
    if (emailVerificationToken != null) {
      data['email_verification_token'] = emailVerificationToken;
    }
    if (otpPurpose != null) {
      data['otp_purpose'] = otpPurpose;
    }
    return data;
  }
}
