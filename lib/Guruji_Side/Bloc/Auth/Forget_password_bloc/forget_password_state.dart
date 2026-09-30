import 'package:equatable/equatable.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/forget_password_model.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgetPassInitialState extends ForgetPasswordState {
  const ForgetPassInitialState();
}

class ForgetPasswordLoadingState extends ForgetPasswordState {
  const ForgetPasswordLoadingState();
}

class ForgetPasswordOtpSentState extends ForgetPasswordState {
  final ForgetPasswordModel response;
  final String mobileNum;

  const ForgetPasswordOtpSentState({
    required this.response,
    required this.mobileNum,
  });

  @override
  List<Object?> get props => [response, mobileNum];
}

class ForgetPasswordOtpVerifyingState extends ForgetPasswordState {
  const ForgetPasswordOtpVerifyingState();
}

class ForgetPasswordOtpVerifiedState extends ForgetPasswordState {
  final String? verificationToken;
  final String? verificationUid;
  final String mobileNum;

  const ForgetPasswordOtpVerifiedState({
    this.verificationToken,
    this.verificationUid,
    required this.mobileNum,
  });

  @override
  List<Object?> get props => [verificationToken, verificationUid, mobileNum];
}

class ForgetPasswordOtpResentState extends ForgetPasswordState {
  const ForgetPasswordOtpResentState();
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordLoadingState extends ForgetPasswordState {
  const ResetPasswordLoadingState();
}

class ResetPasswordSuccessState extends ForgetPasswordState {
  final String message;

  const ResetPasswordSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordErrorState extends ForgetPasswordState {
  final String message;

  const ResetPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
