import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginTypeChanged extends LoginEvent {
  final String loginType;

  const LoginTypeChanged(this.loginType);

  @override
  List<Object?> get props => [loginType];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final String loginType;

  const LoginButtonPressed({
    required this.username,
    required this.password,
    required this.loginType,
  });

  @override
  List<Object?> get props => [username, password, loginType];
}

class PasswordVisibilityChanged extends LoginEvent {
  final bool isPasswordVisible;

  const PasswordVisibilityChanged(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}
