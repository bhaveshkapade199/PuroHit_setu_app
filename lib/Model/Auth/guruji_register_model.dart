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
    return data;
  }
}
