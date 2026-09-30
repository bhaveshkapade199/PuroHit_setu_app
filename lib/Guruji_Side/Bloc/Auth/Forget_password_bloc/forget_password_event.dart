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
