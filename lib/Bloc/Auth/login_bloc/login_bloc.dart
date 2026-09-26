import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Bloc/Auth/login_bloc/login_event.dart';
import 'package:purohitset_app/Bloc/Auth/login_bloc/login_state.dart';
import 'package:purohitset_app/Repository/Auth/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginIntialState()) {
    on<PasswordVisibilityChanged>((event, emit) {
      final currentState = state;

      if (currentState is LoginIntialState) {
        emit(
          LoginIntialState(
            loginType: currentState.loginType,
            isPasswordVisible: event.isPasswordVisible,
          ),
        );
      }
    });
    // Change Yajman / Guruji
    on<LoginTypeChanged>((event, emit) {
      emit(LoginIntialState(loginType: event.loginType));
    });

    // Login
    on<LoginButtonPressed>(_onLogin);
  }

  Future<void> _onLogin(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(const LoginLoadingState());

      debugPrint("Login Type: ${event.loginType}");

      final result = await authRepository.login(event.username, event.password);

      if (result != null) {
        emit(LoginSuccessState(result));
      } else {
        emit(const LoginFailureState('Invalid phone number or password'));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(
          const LoginFailureState(
            'Unable to connect to the server. Please check your internet connection or try again later.',
          ),
        );
      } else {
        emit(
          LoginFailureState(
            e.message ?? 'Something went wrong. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }
}
