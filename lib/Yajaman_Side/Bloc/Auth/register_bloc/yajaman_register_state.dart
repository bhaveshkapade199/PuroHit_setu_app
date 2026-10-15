import 'package:equatable/equatable.dart';
import 'package:purohitset_app/Yajaman_Side/Model/Auth/yajaman_register_model.dart';

abstract class YajamanRegisterState extends Equatable {
  final bool isWhatsappSameAsPhone;
  final bool isPasswordVisible;

  // Phone OTP
  final bool phoneOtpSent;
  final bool phoneVerified;
  final String phoneVerificationUid;
  final String phoneVerificationToken;

  const YajamanRegisterState({
    this.isWhatsappSameAsPhone = false,
    this.isPasswordVisible = false,
    this.phoneOtpSent = false,
    this.phoneVerified = false,
    this.phoneVerificationUid = "",
    this.phoneVerificationToken = "",
  });

  @override
  List<Object?> get props => [
    isWhatsappSameAsPhone,
    isPasswordVisible,
    phoneOtpSent,
    phoneVerified,
    phoneVerificationUid,
    phoneVerificationToken,
  ];
}

class YajamanRegisterInitialState extends YajamanRegisterState {
  const YajamanRegisterInitialState({
    super.isWhatsappSameAsPhone,
    super.isPasswordVisible,
    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,
  });
}

class YajamanRegisterLoadingState extends YajamanRegisterState {
  const YajamanRegisterLoadingState({
    super.isWhatsappSameAsPhone,
    super.isPasswordVisible,
    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,
  });
}

class YajamanRegisterLoadedState extends YajamanRegisterState {
  final YajamanRegisterModel response;

  const YajamanRegisterLoadedState({
    required this.response,
    super.isWhatsappSameAsPhone,
    super.isPasswordVisible,
    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,
  });

  @override
  List<Object?> get props => [
    response,
    isWhatsappSameAsPhone,
    isPasswordVisible,
    phoneOtpSent,
    phoneVerified,
    phoneVerificationUid,
    phoneVerificationToken,
  ];
}

class YajamanRegisterErrorState extends YajamanRegisterState {
  final String? errorMessage;

  const YajamanRegisterErrorState({
    this.errorMessage,
    super.isWhatsappSameAsPhone,
    super.isPasswordVisible,
    super.phoneOtpSent,
    super.phoneVerified,
    super.phoneVerificationUid,
    super.phoneVerificationToken,
  });

  @override
  List<Object?> get props => [
    errorMessage,
    isWhatsappSameAsPhone,
    isPasswordVisible,
    phoneOtpSent,
    phoneVerified,
    phoneVerificationUid,
    phoneVerificationToken,
  ];
}
