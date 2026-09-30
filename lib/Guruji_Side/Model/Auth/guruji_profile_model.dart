class GurujiProfileInfoModel {
  bool? success;
  String? message;
  List<dynamic>? errors;
  Api? api;
  Data? data;

  GurujiProfileInfoModel({
    this.success,
    this.message,
    this.errors,
    this.api,
    this.data,
  });

  factory GurujiProfileInfoModel.fromJson(Map<String, dynamic> json) {
    return GurujiProfileInfoModel(
      success: json['success'],
      message: json['message'],
      errors: json['errors'] != null
          ? List<dynamic>.from(json['errors'])
          : null,
      api: json['api'] != null ? Api.fromJson(json['api']) : null,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'errors': errors,
      'api': api?.toJson(),
      'data': data?.toJson(),
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

class Data {
  Guruji? guruji;
  ProfileCompletion? profileCompletion;
  Authentication? authentication;

  Data({this.guruji, this.profileCompletion, this.authentication});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      guruji: json['guruji'] != null ? Guruji.fromJson(json['guruji']) : null,
      profileCompletion: json['profile_completion'] != null
          ? ProfileCompletion.fromJson(json['profile_completion'])
          : null,
      authentication: json['authentication'] != null
          ? Authentication.fromJson(json['authentication'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guruji': guruji?.toJson(),
      'profile_completion': profileCompletion?.toJson(),
      'authentication': authentication?.toJson(),
    };
  }
}

class Guruji {
  String? gurujiUid;
  String? firstName;
  String? middleName;
  String? lastName;
  String? fullName;
  String? gender;
  String? dateOfBirth;
  String? phone;
  String? alternatePhone;
  String? whatsappNumber;
  String? email;
  String? profilePhoto;
  String? bio;
  String? religion;
  String? vedaShakha;
  String? qualification;
  int? experienceYears;
  String? status;
  bool? emailVerified;
  bool? phoneVerified;
  bool? twoFactorEnabled;
  String? languagePreference;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;
  String? sampraday;
  int? gurujiId;
  String? address;

  Services? services;
  Reviews? reviews;
  Availability? availability;
  Kyc? kyc;

  Guruji({
    this.gurujiUid,
    this.firstName,
    this.middleName,
    this.lastName,
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.phone,
    this.alternatePhone,
    this.whatsappNumber,
    this.email,
    this.profilePhoto,
    this.bio,
    this.religion,
    this.vedaShakha,
    this.qualification,
    this.experienceYears,
    this.status,
    this.emailVerified,
    this.phoneVerified,
    this.twoFactorEnabled,
    this.languagePreference,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
    this.sampraday,
    this.gurujiId,
    this.address,
    this.services,
    this.reviews,
    this.availability,
    this.kyc,
  });

  factory Guruji.fromJson(Map<String, dynamic> json) {
    return Guruji(
      gurujiUid: json['guruji_uid'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      fullName: json['full_name'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      phone: json['phone'],
      alternatePhone: json['alternate_phone'],
      whatsappNumber: json['whatsapp_number'],
      email: json['email'],
      profilePhoto: json['profile_photo'],
      bio: json['bio'],
      religion: json['religion'],
      vedaShakha: json['veda_shakha'],
      qualification: json['qualification'],
      experienceYears: json['experience_years'],
      status: json['status'],
      emailVerified: json['email_verified'],
      phoneVerified: json['phone_verified'],
      twoFactorEnabled: json['two_factor_enabled'],
      languagePreference: json['language_preference'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      profilePhotoUrl: json['profile_photo_url'],
      sampraday: json['sampraday'],
      gurujiId: json['guruji_id'],
      address: json['address'],
      services: json['services'] != null
          ? Services.fromJson(json['services'])
          : null,
      reviews: json['reviews'] != null
          ? Reviews.fromJson(json['reviews'])
          : null,
      availability: json['availability'] != null
          ? Availability.fromJson(json['availability'])
          : null,
      kyc: json['kyc'] != null ? Kyc.fromJson(json['kyc']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guruji_uid': gurujiUid,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'full_name': fullName,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'phone': phone,
      'alternate_phone': alternatePhone,
      'whatsapp_number': whatsappNumber,
      'email': email,
      'profile_photo': profilePhoto,
      'bio': bio,
      'religion': religion,
      'veda_shakha': vedaShakha,
      'qualification': qualification,
      'experience_years': experienceYears,
      'status': status,
      'email_verified': emailVerified,
      'phone_verified': phoneVerified,
      'two_factor_enabled': twoFactorEnabled,
      'language_preference': languagePreference,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'profile_photo_url': profilePhotoUrl,
      'sampraday': sampraday,
      'guruji_id': gurujiId,
      'address': address,
      'services': services?.toJson(),
      'reviews': reviews?.toJson(),
      'availability': availability?.toJson(),
      'kyc': kyc?.toJson(),
    };
  }
}

class Services {
  int? serviceCount;
  dynamic startingPrice;
  bool? homeVisit;
  bool? onlineAvailable;

  Services({
    this.serviceCount,
    this.startingPrice,
    this.homeVisit,
    this.onlineAvailable,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      serviceCount: json['service_count'],
      startingPrice: json['starting_price'],
      homeVisit: json['home_visit'],
      onlineAvailable: json['online_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_count': serviceCount,
      'starting_price': startingPrice,
      'home_visit': homeVisit,
      'online_available': onlineAvailable,
    };
  }
}

class Reviews {
  double? averageRating;
  int? totalReviews;

  Reviews({this.averageRating, this.totalReviews});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      averageRating: json['average_rating'] != null
          ? (json['average_rating'] as num).toDouble()
          : null,
      totalReviews: json['total_reviews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'average_rating': averageRating, 'total_reviews': totalReviews};
  }
}

class Availability {
  bool? available;
  List<dynamic>? availableDays;

  Availability({this.available, this.availableDays});

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      available: json['available'],
      availableDays: json['available_days'] != null
          ? List<dynamic>.from(json['available_days'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'available': available, 'available_days': availableDays};
  }
}

class Kyc {
  bool? submitted;
  String? verificationStatus;
  bool? verified;

  Kyc({this.submitted, this.verificationStatus, this.verified});

  factory Kyc.fromJson(Map<String, dynamic> json) {
    return Kyc(
      submitted: json['submitted'],
      verificationStatus: json['verification_status'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'submitted': submitted,
      'verification_status': verificationStatus,
      'verified': verified,
    };
  }
}

class ProfileCompletion {
  int? percentage;
  int? completed;
  int? total;
  List<String>? missing;

  ProfileCompletion({
    this.percentage,
    this.completed,
    this.total,
    this.missing,
  });

  factory ProfileCompletion.fromJson(Map<String, dynamic> json) {
    return ProfileCompletion(
      percentage: json['percentage'],
      completed: json['completed'],
      total: json['total'],
      missing: json['missing'] != null
          ? List<String>.from(json['missing'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'percentage': percentage,
      'completed': completed,
      'total': total,
      'missing': missing,
    };
  }
}

class Authentication {
  bool? authenticated;
  String? tokenType;
  String? expiresAt;
  String? tokenJti;

  Authentication({
    this.authenticated,
    this.tokenType,
    this.expiresAt,
    this.tokenJti,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return Authentication(
      authenticated: json['authenticated'],
      tokenType: json['token_type'],
      expiresAt: json['expires_at'],
      tokenJti: json['token_jti'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authenticated': authenticated,
      'token_type': tokenType,
      'expires_at': expiresAt,
      'token_jti': tokenJti,
    };
  }
}
