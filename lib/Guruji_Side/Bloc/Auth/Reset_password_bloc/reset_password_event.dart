import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ResetPasswordReqEvent extends ResetPasswordEvent {
  final String phone;
  final String verificationUid;
  final String purpose;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordReqEvent({
    required this.phone,
    required this.verificationUid,
    required this.purpose,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
    phone,
    verificationUid,
    purpose,
    newPassword,
    confirmPassword,
  ];
}
