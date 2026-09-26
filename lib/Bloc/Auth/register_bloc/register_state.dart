import 'package:equatable/equatable.dart';

import 'package:purohitset_app/Model/Auth/guruji_register_model.dart';

abstract class RegisterState extends Equatable {
  final String gender;
  final String religion;
  final String sampraday;
  final String vedaShakha;

  final bool isWhatsappSameAsPhone;

  // Phone OTP
  final bool phoneOtpSent;
  final bool phoneVerified;

  // Email OTP
  final bool emailOtpSent;
  final bool emailVerified;

  //for the password visible

  final bool isPasswordVisible;

  const RegisterState({
    this.gender = "",
    this.religion = "",
    this.sampraday = "",
    this.vedaShakha = "",
    this.isWhatsappSameAsPhone = false,

    this.phoneOtpSent = false,
    this.phoneVerified = false,

    this.emailOtpSent = false,
    this.emailVerified = false,

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

    emailOtpSent,
    emailVerified,
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

    super.emailOtpSent,
    super.emailVerified,
    super.isPasswordVisible
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

    super.emailOtpSent,
    super.emailVerified,
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

    super.emailOtpSent,
    super.emailVerified,
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

    emailOtpSent,
    emailVerified,
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

    super.emailOtpSent,
    super.emailVerified,
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

    emailOtpSent,
    emailVerified,
    isPasswordVisible,
  ];
}
