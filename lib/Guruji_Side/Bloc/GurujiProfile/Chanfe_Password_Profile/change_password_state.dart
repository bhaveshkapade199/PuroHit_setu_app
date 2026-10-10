import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  final bool isCurrentPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;

  const ChangePasswordState({
    this.isCurrentPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  @override
  List<Object?> get props => [
    isCurrentPasswordVisible,
    isNewPasswordVisible,
    isConfirmPasswordVisible,
  ];
}

class ChangePasswordInitialState extends ChangePasswordState {
  const ChangePasswordInitialState({
    super.isCurrentPasswordVisible,
    super.isNewPasswordVisible,
    super.isConfirmPasswordVisible,
  });
}

class ChangePasswordLoadingState extends ChangePasswordState {
  const ChangePasswordLoadingState({
    super.isCurrentPasswordVisible,
    super.isNewPasswordVisible,
    super.isConfirmPasswordVisible,
  });
}

class ChangePasswordSuccessState extends ChangePasswordState {
  final String message;

  const ChangePasswordSuccessState({
    required this.message,
    super.isCurrentPasswordVisible,
    super.isNewPasswordVisible,
    super.isConfirmPasswordVisible,
  });

  @override
  List<Object?> get props => [...super.props, message];
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordErrorState({
    required this.errorMessage,
    super.isCurrentPasswordVisible,
    super.isNewPasswordVisible,
    super.isConfirmPasswordVisible,
  });

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
