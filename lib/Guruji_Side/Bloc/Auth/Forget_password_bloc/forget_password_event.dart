import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {}

class ForgetPasswordReqEvent extends ForgetPasswordEvent {
  final String mobileNum;
  final String purpose;

  ForgetPasswordReqEvent({
    required this.mobileNum,
    this.purpose = 'guruji_forgot_password',
  });

  @override
  List<Object?> get props => [mobileNum, purpose];
}

class VerifyForgetPasswordOtpEvent extends ForgetPasswordEvent {
  final String otp;

  VerifyForgetPasswordOtpEvent(this.otp);

  @override
  List<Object?> get props => [otp];
}

class ResendForgetPasswordOtpEvent extends ForgetPasswordEvent {
  @override
  List<Object?> get props => [];
}

class ResetPasswordSubmitEvent extends ForgetPasswordEvent {
  final String phone;
  final String verificationUid;
  final String newPassword;
  final String confirmPassword;
  final String purpose;
  final String? verificationToken;

  ResetPasswordSubmitEvent({
    required this.phone,
    required this.verificationUid,
    required this.newPassword,
    required this.confirmPassword,
    this.purpose = 'guruji_forgot_password',
    this.verificationToken,
  });

  @override
  List<Object?> get props => [
        phone,
        verificationUid,
        newPassword,
        confirmPassword,
        purpose,
        verificationToken,
      ];
}
