import 'package:equatable/equatable.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_login_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginIntialState extends LoginState {
  final String loginType;
  final bool isPasswordVisible;
  const LoginIntialState({
    this.loginType = 'Yajman',
    this.isPasswordVisible = false,
  });

  @override
  List<Object?> get props => [loginType];
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  final GurujiLoginModel loginModel;

  const LoginSuccessState(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  const LoginFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
