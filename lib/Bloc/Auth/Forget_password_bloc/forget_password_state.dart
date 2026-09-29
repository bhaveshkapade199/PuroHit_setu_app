import 'package:equatable/equatable.dart';
import 'package:purohitset_app/Model/Auth/forget_password_model.dart';

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

class ForgetPasswordSuccessState extends ForgetPasswordState {
  final ForgetPasswordModel response;

  const ForgetPasswordSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
