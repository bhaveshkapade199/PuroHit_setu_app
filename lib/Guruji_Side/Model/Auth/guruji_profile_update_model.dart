class GurujiProfileUpdateModel {
  final bool success;
  final String message;
  final List<dynamic> errors;
  final Api? api;
  final List<String> updatedSections;
  final Guruji? guruji;
  final List<Address> addresses;
  final List<Availability> availability;
  final List<BankAccount> bankAccounts;
  final List<Service> services;
  final dynamic kyc;
  final dynamic wallet;
  final Reviews? reviews;
  final Verification? verification;

  GurujiProfileUpdateModel({
    required this.success,
    required this.message,
    required this.errors,
    this.api,
    required this.updatedSections,
    this.guruji,
    required this.addresses,
    required this.availability,
    required this.bankAccounts,
    required this.services,
    this.kyc,
    this.wallet,
    this.reviews,
    this.verification,
  });

  factory GurujiProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'])
        : json;

    List<dynamic> parsedErrors = [];
    if (json['errors'] is List) {
      parsedErrors = List<dynamic>.from(json['errors']);
    } else if (json['errors'] is Map) {
      parsedErrors = (json['errors'] as Map).values.toList();
    } else if (json['errors'] is String) {
      parsedErrors = [json['errors']];
    }

    return GurujiProfileUpdateModel(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      errors: parsedErrors,
      api: json['api'] is Map
          ? Api.fromJson(Map<String, dynamic>.from(json['api']))
          : null,
      updatedSections: data['updated_sections'] is List
          ? (data['updated_sections'] as List).map((e) => e.toString()).toList()
          : [],
      guruji: data['guruji'] is Map
          ? Guruji.fromJson(Map<String, dynamic>.from(data['guruji']))
          : null,
      addresses: (data['addresses'] as List? ?? [])
          .whereType<Map>()
          .map((e) => Address.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      availability: (data['availability'] as List? ?? [])
          .whereType<Map>()
          .map((e) => Availability.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      bankAccounts: (data['bank_accounts'] as List? ?? [])
          .whereType<Map>()
          .map((e) => BankAccount.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      services: (data['services'] as List? ?? [])
          .whereType<Map>()
          .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      kyc: data['kyc'],
      wallet: data['wallet'],
      reviews: data['reviews'] is Map
          ? Reviews.fromJson(Map<String, dynamic>.from(data['reviews']))
          : null,
      verification: data['verification'] is Map
          ? Verification.fromJson(Map<String, dynamic>.from(data['verification']))
          : null,
    );
  }
}

class Api {
  final String name;
  final String version;
  final String endpoint;
  final String method;

  Api({
    required this.name,
    required this.version,
    required this.endpoint,
    required this.method,
  });

  factory Api.fromJson(Map<String, dynamic> json) => Api(
    name: json['name']?.toString() ?? '',
    version: json['version']?.toString() ?? '',
    endpoint: json['endpoint']?.toString() ?? '',
    method: json['method']?.toString() ?? '',
  );
}

class Guruji {
  final int id;
  final String gurujiUid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String gender;
  final DateTime? dateOfBirth;
  final String phone;
  final String alternatePhone;
  final String whatsappNumber;
  final String email;
  final dynamic profilePhoto;
  final String bio;
  final String religion;
  final String sampraday;
  final String vedaShakha;
  final dynamic qualification;
  final int experienceYears;
  final String status;
  final bool emailVerified;
  final bool phoneVerified;
  final bool twoFactorEnabled;
  final String languagePreference;
  final String createdAt;
  final String updatedAt;

  Guruji({
    required this.id,
    required this.gurujiUid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.alternatePhone,
    required this.whatsappNumber,
    required this.email,
    required this.profilePhoto,
    required this.bio,
    required this.religion,
    required this.sampraday,
    required this.vedaShakha,
    required this.qualification,
    required this.experienceYears,
    required this.status,
    required this.emailVerified,
    required this.phoneVerified,
    required this.twoFactorEnabled,
    required this.languagePreference,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Guruji.fromJson(Map<String, dynamic> json) {
    final rawDob = json['date_of_birth'] ?? json['dob'];
    return Guruji(
      id: _int(json['id'] ?? json['guruji_id']),
      gurujiUid: json['guruji_uid']?.toString() ?? '',
      firstName: json['first_name']?.toString() ?? '',
      middleName: json['middle_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      dateOfBirth: rawDob == null
          ? null
          : DateTime.tryParse(rawDob.toString()),
      phone: json['phone']?.toString() ?? '',
      alternatePhone: json['alternate_phone']?.toString() ?? '',
      whatsappNumber: json['whatsapp_number']?.toString() ?? json['whatsapp']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      profilePhoto: json['profile_photo'] ?? json['profile_photo_url'],
      bio: json['bio']?.toString() ?? '',
      religion: json['religion']?.toString() ?? '',
      sampraday: json['sampraday']?.toString() ?? json['sampradaya']?.toString() ?? '',
      vedaShakha: json['veda_shakha']?.toString() ?? '',
      qualification: json['qualification'],
      experienceYears: _int(json['experience_years']),
      status: json['status']?.toString() ?? '',
      emailVerified: json['email_verified'] == true || json['email_verified'] == 1,
      phoneVerified: json['phone_verified'] == true || json['phone_verified'] == 1,
      twoFactorEnabled: json['two_factor_enabled'] == true || json['two_factor_enabled'] == 1,
      languagePreference: json['language_preference']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }
}

class Address {
  final int id;
  final String addressType;
  final String addressLine1;
  final String? addressLine2;
  final String? village;
  final String taluka;
  final String district;
  final String state;
  final String country;
  final String pincode;
  final double latitude;
  final double longitude;

  Address({
    required this.id,
    required this.addressType,
    required this.addressLine1,
    required this.addressLine2,
    required this.village,
    required this.taluka,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: _int(json['id']),
    addressType: json['address_type']?.toString() ?? '',
    addressLine1: json['address_line1']?.toString() ?? '',
    addressLine2: json['address_line2']?.toString(),
    village: json['village']?.toString(),
    taluka: json['taluka']?.toString() ?? '',
    district: json['district']?.toString() ?? '',
    state: json['state']?.toString() ?? '',
    country: json['country']?.toString() ?? '',
    pincode: json['pincode']?.toString() ?? '',
    latitude: _double(json['latitude']),
    longitude: _double(json['longitude']),
  );
}

class Availability {
  final int id;
  final String dayName;
  final String startTime;
  final String endTime;
  final bool isAvailable;

  Availability({
    required this.id,
    required this.dayName,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    id: _int(json['id']),
    dayName: json['day_name']?.toString() ?? '',
    startTime: json['start_time']?.toString() ?? '',
    endTime: json['end_time']?.toString() ?? '',
    isAvailable: json['is_available'] == true || json['is_available'] == 1,
  );
}

class BankAccount {
  final int id;
  final String accountHolderName;
  final String bankName;
  final String accountNumberMasked;
  final String ifscCode;
  final String upiId;
  final bool isPrimary;

  BankAccount({
    required this.id,
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumberMasked,
    required this.ifscCode,
    required this.upiId,
    required this.isPrimary,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    id: _int(json['id']),
    accountHolderName: json['account_holder_name']?.toString() ?? '',
    bankName: json['bank_name']?.toString() ?? '',
    accountNumberMasked: json['account_number_masked']?.toString() ?? json['account_number']?.toString() ?? '',
    ifscCode: json['ifsc_code']?.toString() ?? '',
    upiId: json['upi_id']?.toString() ?? '',
    isPrimary: json['is_primary'] == true || json['is_primary'] == 1,
  );
}

class Service {
  final int id;
  final int serviceId;
  final int experienceYears;
  final int price;
  final int durationMinutes;
  final bool homeVisit;
  final bool onlineAvailable;
  final int serviceRadiusKm;
  final int status;
  final String createdAt;
  final String updatedAt;

  Service({
    required this.id,
    required this.serviceId,
    required this.experienceYears,
    required this.price,
    required this.durationMinutes,
    required this.homeVisit,
    required this.onlineAvailable,
    required this.serviceRadiusKm,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: _int(json['id']),
    serviceId: _int(json['service_id']),
    experienceYears: _int(json['experience_years']),
    price: _int(json['price']),
    durationMinutes: _int(json['duration_minutes']),
    homeVisit: json['home_visit'] == true || json['home_visit'] == 1,
    onlineAvailable: json['online_available'] == true || json['online_available'] == 1,
    serviceRadiusKm: _int(json['service_radius_km']),
    status: _int(json['status']),
    createdAt: json['created_at']?.toString() ?? '',
    updatedAt: json['updated_at']?.toString() ?? '',
  );
}

class Reviews {
  final int reviewCount;
  final dynamic averageRating;

  Reviews({required this.reviewCount, required this.averageRating});

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    reviewCount: _int(json['review_count'] ?? json['total_reviews']),
    averageRating: json['average_rating'],
  );
}

class Verification {
  final dynamic purpose;
  final bool phoneChanged;
  final bool emailChanged;
  final bool phoneVerified;
  final bool emailVerified;

  Verification({
    required this.purpose,
    required this.phoneChanged,
    required this.emailChanged,
    required this.phoneVerified,
    required this.emailVerified,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    purpose: json['purpose'],
    phoneChanged: json['phone_changed'] == true || json['phone_changed'] == 1,
    emailChanged: json['email_changed'] == true || json['email_changed'] == 1,
    phoneVerified: json['phone_verified'] == true || json['phone_verified'] == 1,
    emailVerified: json['email_verified'] == true || json['email_verified'] == 1,
  );
}

int _int(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _double(dynamic value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0.0;
}
