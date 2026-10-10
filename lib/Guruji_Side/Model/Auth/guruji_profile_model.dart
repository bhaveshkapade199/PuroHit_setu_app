class GurujiProfileInfoModel {
  final bool success;
  final String message;
  final List<dynamic> errors;
  final Api api;
  final Data data;

  GurujiProfileInfoModel({
    required this.success,
    required this.message,
    required this.errors,
    required this.api,
    required this.data,
  });

  factory GurujiProfileInfoModel.fromJson(Map<String, dynamic> json) {
    return GurujiProfileInfoModel(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      errors: json['errors'] is List ? json['errors'] : [],
      api: Api.fromJson(_map(json['api'])),
      data: Data.fromJson(_map(json['data'])),
    );
  }
}

Map<String, dynamic> _map(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return <String, dynamic>{};
}

String _str(dynamic value) => value?.toString() ?? '';

int _int(dynamic value) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

bool _bool(dynamic value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  return value?.toString().toLowerCase() == 'true' || value?.toString() == '1';
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
    name: _str(json['name']),
    version: _str(json['version']),
    endpoint: _str(json['endpoint']),
    method: _str(json['method']),
  );
}

class Data {
  final Guruji guruji;
  final ProfileCompletion profileCompletion;
  final Authentication authentication;

  Data({
    required this.guruji,
    required this.profileCompletion,
    required this.authentication,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    guruji: Guruji.fromJson(_map(json['guruji'])),
    profileCompletion: ProfileCompletion.fromJson(
      _map(json['profile_completion']),
    ),
    authentication: Authentication.fromJson(_map(json['authentication'])),
  );
}

class Authentication {
  final bool authenticated;
  final String tokenType;
  final String expiresAt;
  final String tokenJti;

  Authentication({
    required this.authenticated,
    required this.tokenType,
    required this.expiresAt,
    required this.tokenJti,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    authenticated: _bool(json['authenticated']),
    tokenType: _str(json['token_type']),
    expiresAt: _str(json['expires_at']),
    tokenJti: _str(json['token_jti']),
  );
}

class Guruji {
  final String gurujiUid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String gender;
  final DateTime? dateOfBirth;
  final String phone;
  final dynamic alternatePhone;
  final String whatsappNumber;
  final String email;
  final dynamic profilePhoto;
  final dynamic bio;
  final String religion;
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
  final String profilePhotoUrl;
  final String sampraday;
  final int gurujiId;
  final dynamic address;
  final Services services;
  final Reviews reviews;
  final Availability availability;
  final Kyc kyc;

  Guruji({
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
    required this.profilePhotoUrl,
    required this.sampraday,
    required this.gurujiId,
    required this.address,
    required this.services,
    required this.reviews,
    required this.availability,
    required this.kyc,
  });

  factory Guruji.fromJson(Map<String, dynamic> json) {
    final rawDob = json['date_of_birth'] ?? json['dob'];
    final parsedDob = rawDob == null
        ? null
        : DateTime.tryParse(rawDob.toString());

    return Guruji(
      gurujiUid: _str(json['guruji_uid']),
      firstName: _str(json['first_name']),
      middleName: _str(json['middle_name']),
      lastName: _str(json['last_name']),
      fullName: _str(json['full_name']).isNotEmpty
          ? _str(json['full_name'])
          : [json['first_name'], json['middle_name'], json['last_name']]
                .where((e) => e != null && e.toString().trim().isNotEmpty)
                .join(' '),
      gender: _str(json['gender']),
      dateOfBirth: parsedDob,
      phone: _str(json['phone']),
      alternatePhone: json['alternate_phone'],
      whatsappNumber: _str(json['whatsapp_number'] ?? json['whatsapp']),
      email: _str(json['email']),
      profilePhoto: json['profile_photo'],
      bio: json['bio'],
      religion: _str(json['religion']),
      vedaShakha: _str(json['veda_shakha']),
      qualification: json['qualification'],
      experienceYears: _int(json['experience_years']),
      status: _str(json['status']),
      emailVerified: _bool(json['email_verified']),
      phoneVerified: _bool(json['phone_verified']),
      twoFactorEnabled: _bool(json['two_factor_enabled']),
      languagePreference: _str(json['language_preference']),
      createdAt: _str(json['created_at']),
      updatedAt: _str(json['updated_at']),
      profilePhotoUrl: _str(json['profile_photo_url']),
      sampraday: _str(json['sampraday']),
      gurujiId: _int(json['guruji_id']),
      address: json['address'],
      services: Services.fromJson(_map(json['services'])),
      reviews: Reviews.fromJson(_map(json['reviews'])),
      availability: Availability.fromJson(_map(json['availability'])),
      kyc: Kyc.fromJson(_map(json['kyc'])),
    );
  }
}

class Services {
  final int serviceCount;
  final dynamic startingPrice;
  final bool homeVisit;
  final bool onlineAvailable;
  final List<dynamic> items;

  Services({
    required this.serviceCount,
    required this.startingPrice,
    required this.homeVisit,
    required this.onlineAvailable,
    required this.items,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    serviceCount: _int(json['service_count']),
    startingPrice: json['starting_price'],
    homeVisit: _bool(json['home_visit']),
    onlineAvailable: _bool(json['online_available']),
    items: json['items'] is List ? json['items'] : [],
  );
}

class Reviews {
  final int averageRating;
  final int totalReviews;

  Reviews({required this.averageRating, required this.totalReviews});

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    averageRating: _int(json['average_rating']),
    totalReviews: _int(json['total_reviews']),
  );
}

class Availability {
  final bool available;
  final List<String> availableDays;
  final List<Schedule> schedule;

  Availability({
    required this.available,
    required this.availableDays,
    required this.schedule,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    available: _bool(json['available']),
    availableDays: json['available_days'] is List
        ? (json['available_days'] as List).map((e) => e.toString()).toList()
        : [],
    schedule: json['schedule'] is List
        ? (json['schedule'] as List)
              .map((e) => Schedule.fromJson(_map(e)))
              .toList()
        : [],
  );
}

class Schedule {
  final int id;
  final String dayName;
  final dynamic startTime;
  final dynamic endTime;
  final bool isAvailable;

  Schedule({
    required this.id,
    required this.dayName,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: _int(json['id']),
    dayName: _str(json['day_name']),
    startTime: json['start_time'],
    endTime: json['end_time'],
    isAvailable: _bool(json['is_available']),
  );
}

class Kyc {
  final bool submitted;
  final dynamic verificationStatus;
  final bool verified;

  Kyc({
    required this.submitted,
    required this.verificationStatus,
    required this.verified,
  });

  factory Kyc.fromJson(Map<String, dynamic> json) => Kyc(
    submitted: _bool(json['submitted']),
    verificationStatus: json['verification_status'],
    verified: _bool(json['verified']),
  );
}

class ProfileCompletion {
  final int percentage;
  final int completed;
  final int total;
  final List<String> missing;

  ProfileCompletion({
    required this.percentage,
    required this.completed,
    required this.total,
    required this.missing,
  });

  factory ProfileCompletion.fromJson(Map<String, dynamic> json) =>
      ProfileCompletion(
        percentage: _int(json['percentage']),
        completed: _int(json['completed']),
        total: _int(json['total']),
        missing: json['missing'] is List
            ? (json['missing'] as List).map((e) => e.toString()).toList()
            : [],
      );
}
