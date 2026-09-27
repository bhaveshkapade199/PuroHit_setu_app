import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final String firstName;
  final String middleName;
  final String lastName;

  final String gender;
  final String dateOfBirth;

  final String phone;
  final String alternatePhone;
  final String whatsappNumber;
  final String email;

  final String password;

  final String bio;
  final String religion;
  final String sampraday;
  final String vedaShakha;
  final String qualification;
  final int experienceYears;
  final String languagePreference;

  const RegisterUserEvent({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.alternatePhone,
    required this.whatsappNumber,
    required this.email,
    required this.password,
    required this.bio,
    required this.religion,
    required this.sampraday,
    required this.vedaShakha,
    required this.qualification,
    required this.experienceYears,
    required this.languagePreference,
  });

  @override
  List<Object?> get props => [
    firstName,
    middleName,
    lastName,
    gender,
    dateOfBirth,
    phone,
    alternatePhone,
    whatsappNumber,
    email,
    password,
    bio,
    religion,
    sampraday,
    vedaShakha,
    qualification,
    experienceYears,
    languagePreference,
  ];
}

class GenderChangedEvent extends RegisterEvent {
  final String gender;

  const GenderChangedEvent(this.gender);

  @override
  List<Object?> get props => [gender];
}

class ReligionChangedEvent extends RegisterEvent {
  final String religion;

  const ReligionChangedEvent(this.religion);

  @override
  List<Object?> get props => [religion];
}

class SampradayChangedEvent extends RegisterEvent {
  final String sampraday;

  const SampradayChangedEvent(this.sampraday);

  @override
  List<Object?> get props => [sampraday];
}

class VedaShakhaChangedEvent extends RegisterEvent {
  final String vedaShakha;

  const VedaShakhaChangedEvent(this.vedaShakha);

  @override
  List<Object?> get props => [vedaShakha];
}

class WhatsappSameAsPhoneChangedEvent extends RegisterEvent {
  final bool isSame;

  const WhatsappSameAsPhoneChangedEvent(this.isSame);

  @override
  List<Object?> get props => [isSame];
}

class SendPhoneOtpEvent extends RegisterEvent {
  final String phone;

  const SendPhoneOtpEvent([this.phone = ""]);

  @override
  List<Object?> get props => [phone];
}

class VerifyPhoneOtpEvent extends RegisterEvent {
  final String otp;
  final String phone;

  const VerifyPhoneOtpEvent(this.otp, [this.phone = ""]);

  @override
  List<Object?> get props => [otp, phone];
}

class SendEmailOtpEvent extends RegisterEvent {
  final String email;

  const SendEmailOtpEvent([this.email = ""]);

  @override
  List<Object?> get props => [email];
}

class VerifyEmailOtpEvent extends RegisterEvent {
  final String otp;
  final String email;

  const VerifyEmailOtpEvent(this.otp, [this.email = ""]);

  @override
  List<Object?> get props => [otp, email];
}

class PasswordVisibilityEvent extends RegisterEvent {
  final bool isVisible;

  const PasswordVisibilityEvent(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}
