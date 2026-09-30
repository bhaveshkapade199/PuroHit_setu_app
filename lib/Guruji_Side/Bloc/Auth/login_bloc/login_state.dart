import 'package:equatable/equatable.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_login_model.dart';

abstract class LoginState extends Equatable {
  final String loginType;
  final bool isPasswordVisible;

  const LoginState({this.loginType = 'Yajman', this.isPasswordVisible = false});

  @override
  List<Object?> get props => [loginType, isPasswordVisible];
}

class LoginIntialState extends LoginState {
  const LoginIntialState({super.loginType, super.isPasswordVisible});
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState({super.loginType, super.isPasswordVisible});
}

class LoginSuccessState extends LoginState {
  final GurujiLoginModel loginModel;

  const LoginSuccessState(
    this.loginModel, {
    super.loginType,
    super.isPasswordVisible,
  });

  @override
  List<Object?> get props => [...super.props, loginModel];
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  const LoginFailureState(
    this.errorMessage, {
    super.loginType,
    super.isPasswordVisible,
  });

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
