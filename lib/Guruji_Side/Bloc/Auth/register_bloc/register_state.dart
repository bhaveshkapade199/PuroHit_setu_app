import 'package:equatable/equatable.dart';

import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_register_model.dart';

abstract class RegisterState extends Equatable {
  final String gender;
  final String religion;
  final String sampraday;
  final String vedaShakha;

  final bool isWhatsappSameAsPhone;

  // Phone OTP
  final bool phoneOtpSent;
  final bool phoneVerified;
  final String phoneVerificationUid;
  final String phoneVerificationToken;

  // Email OTP
  final bool emailOtpSent;
  final bool emailVerified;
  final String emailVerificationUid;
  final String emailVerificationToken;

  // for the password visible
  final bool isPasswordVisible;

  const RegisterState({
    this.gender = "",
    this.religion = "",
    this.sampraday = "",
    this.vedaShakha = "",
    this.isWhatsappSameAsPhone = false,

    this.phoneOtpSent = false,
    this.phoneVerified = false,
    this.phoneVerificationUid = "",
    this.phoneVerificationToken = "",

    this.emailOtpSent = false,
    this.emailVerified = false,
    this.emailVerificationUid = "",
    this.emailVerificationToken = "",

    this.isPasswordVisible = false,
  });

  @override
  List<Object?> get props => [
    gender,
    religion,
    sampraday,
    vedaShakha,
    isWhatsappSameAsPhone,

    phoneOtpSent,
    phoneVerified,
    phoneVerificationUid,
    phoneVerificationToken,

    emailOtpSent,
    emailVerified,
    emailVerificationUid,
    emailVerificationToken,

    isPasswordVisible,
  ];
}

// =====================================================
// INITIAL
// =====================================================

class RegisterInitialState extends RegisterState {
  const RegisterInitialState({
    super.gender,
    super.religion,
    super.sampraday,
    super.vedaShakha,
    super.isWhatsappSameAsPhone,

    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,

    super.emailOtpSent,
    super.emailVerified,
    super.emailVerificationUid,
    super.emailVerificationToken,

    super.isPasswordVisible,
  });
}

// =====================================================
// LOADING
// =====================================================

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState({
    super.gender,
    super.religion,
    super.sampraday,
    super.vedaShakha,
    super.isWhatsappSameAsPhone,

    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,

    super.emailOtpSent,
    super.emailVerified,
    super.emailVerificationUid,
    super.emailVerificationToken,

    super.isPasswordVisible,
  });
}

// =====================================================
// LOADED
// =====================================================

class RegisterLoadedState extends RegisterState {
  final GurujiRegisterModel response;

  const RegisterLoadedState({
    required this.response,

    super.gender,
    super.religion,
    super.sampraday,
    super.vedaShakha,
    super.isWhatsappSameAsPhone,

    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,

    super.emailOtpSent,
    super.emailVerified,
    super.emailVerificationUid,
    super.emailVerificationToken,

    super.isPasswordVisible,
  });

  @override
  List<Object?> get props => [
    response,
    gender,
    religion,
    sampraday,
    vedaShakha,
    isWhatsappSameAsPhone,

    phoneOtpSent,
    phoneVerified,
    phoneVerificationUid,
    phoneVerificationToken,

    emailOtpSent,
    emailVerified,
    emailVerificationUid,
    emailVerificationToken,

    isPasswordVisible,
  ];
}

// =====================================================
// ERROR
// =====================================================

class RegisterErrorState extends RegisterState {
  final String? errorMessage;

  const RegisterErrorState({
    this.errorMessage,

    super.gender,
    super.religion,
    super.sampraday,
    super.vedaShakha,
    super.isWhatsappSameAsPhone,

    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,

    super.emailOtpSent,
    super.emailVerified,
    super.emailVerificationUid,
    super.emailVerificationToken,

    super.isPasswordVisible,
  });

  @override
  List<Object?> get props => [
    errorMessage,
    gender,
    religion,
    sampraday,
    vedaShakha,
    isWhatsappSameAsPhone,

    phoneOtpSent,
    phoneVerified,
    phoneVerificationUid,
    phoneVerificationToken,

    emailOtpSent,
    emailVerified,
    emailVerificationUid,
    emailVerificationToken,

    isPasswordVisible,
  ];
}
