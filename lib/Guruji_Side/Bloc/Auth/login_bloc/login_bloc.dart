import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_state.dart';
import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginIntialState()) {
    // Password Visibility
    on<PasswordVisibilityChanged>((event, emit) {
      emit(
        LoginIntialState(
          loginType: state.loginType,
          isPasswordVisible: event.isPasswordVisible,
        ),
      );
    });

    // Change Login Type
    on<LoginTypeChanged>((event, emit) {
      emit(
        LoginIntialState(
          loginType: event.loginType,
          isPasswordVisible: state.isPasswordVisible,
        ),
      );
    });

    // Login
    on<LoginButtonPressed>(_onLogin);
  }

  Future<void> _onLogin(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    final loginType = event.loginType;
    final isVisible = state.isPasswordVisible;

    try {
      emit(
        LoginLoadingState(loginType: loginType, isPasswordVisible: isVisible),
      );

      debugPrint('Login Type: $loginType');

      final result = await authRepository.login(event.username, event.password);

      if (result != null) {
        emit(
          LoginSuccessState(
            result,
            loginType: loginType,
            isPasswordVisible: isVisible,
          ),
        );
      } else {
        emit(
          LoginFailureState(
            'Invalid phone number or password. Please try again.',
            loginType: loginType,
            isPasswordVisible: isVisible,
          ),
        );
      }
    } on DioException catch (e) {
      String errorMessage;

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage =
            'Unable to connect to the server. Please check your internet connection.';
      } else if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403) {
        errorMessage = 'Incorrect phone number or password. Please try again.';
      } else {
        final responseData = e.response?.data;

        if (responseData is Map &&
            responseData['message'] is String &&
            (responseData['message'] as String).isNotEmpty) {
          errorMessage = responseData['message'] as String;
        } else {
          errorMessage = 'Something went wrong. Please try again.';
        }
      }

      emit(
        LoginFailureState(
          errorMessage,
          loginType: loginType,
          isPasswordVisible: isVisible,
        ),
      );
    } catch (e) {
      emit(
        LoginFailureState(
          'Something went wrong. Please try again.',
          loginType: loginType,
          isPasswordVisible: isVisible,
        ),
      );
    }
  }
}
