class GurujiRegisterModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? phone;
  String? alternatePhone;
  String? whatsappNumber;
  String? email;
  String? password;
  String? bio;
  String? religion;
  String? sampraday;
  String? vedaShakha;
  String? qualification;
  int? experienceYears;
  String? languagePreference;

  GurujiRegisterModel({
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.phone,
    this.alternatePhone,
    this.whatsappNumber,
    this.email,
    this.password,
    this.bio,
    this.religion,
    this.sampraday,
    this.vedaShakha,
    this.qualification,
    this.experienceYears,
    this.languagePreference,
  });

  GurujiRegisterModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    password = json['password'];
    bio = json['bio'];
    religion = json['religion'];
    sampraday = json['sampraday'];
    vedaShakha = json['veda_shakha'];
    qualification = json['qualification'];
    experienceYears = json['experience_years'];
    languagePreference = json['language_preference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['phone'] = phone;
    data['alternate_phone'] = alternatePhone;
    data['whatsapp_number'] = whatsappNumber;
    data['email'] = email;
    data['password'] = password;
    data['bio'] = bio;
    data['religion'] = religion;
    data['sampraday'] = sampraday;
    data['veda_shakha'] = vedaShakha;
    data['qualification'] = qualification;
    data['experience_years'] = experienceYears;
    data['language_preference'] = languagePreference;
    return data;
  }
}
