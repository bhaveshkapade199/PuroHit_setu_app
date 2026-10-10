import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class ChangePasswordUserEvent extends ChangePasswordEvent {
  final String currentpassword;
  final String newpassword;
  final String confirmpassword;

  const ChangePasswordUserEvent({
    required this.currentpassword,
    required this.newpassword,
    required this.confirmpassword,
  });

  @override
  List<Object?> get props => [currentpassword, newpassword, confirmpassword];
}

class ToggleCurrentPasswordVisibility extends ChangePasswordEvent {}

class ToggleNewPasswordVisibility extends ChangePasswordEvent {}

class ToggleConfirmPasswordVisibility extends ChangePasswordEvent {}
