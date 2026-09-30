import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_state.dart';
import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final AuthRepository _authRepository = AuthRepository();

  // Store verification data for OTP & reset steps
  String? _verificationUid;
  String? _verificationToken;
  String? _channel;
  String? _destination;
  String? _purpose;
  String? _mobileNum;

  ForgetPasswordBloc() : super(const ForgetPassInitialState()) {
    on<ForgetPasswordReqEvent>(_onForgetPasswordRequest);
    on<VerifyForgetPasswordOtpEvent>(_onVerifyOtp);
    on<ResendForgetPasswordOtpEvent>(_onResendOtp);
    on<ResetPasswordSubmitEvent>(_onResetPasswordSubmit);
  }

  // ─── Send OTP ──────────────────────────────────────────────────────────────
  Future<void> _onForgetPasswordRequest(
    ForgetPasswordReqEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(const ForgetPasswordLoadingState());

    try {
      final response = await _authRepository.forgetPassfunction(
        event.mobileNum,
        event.purpose,
      );

      if (response != null && response.success == true) {
        _verificationUid = response.verification?.verificationUid ??
            response.data?.verification?.verificationUid;
        _channel = response.verification?.channel ??
            response.data?.verification?.channel ??
            'phone';
        _destination = response.verification?.destination ??
            response.data?.verification?.destination ??
            event.mobileNum;
        _purpose = response.verification?.purpose ??
            response.data?.verification?.purpose ??
            event.purpose;
        _mobileNum = event.mobileNum;

        emit(ForgetPasswordOtpSentState(
          response: response,
          mobileNum: event.mobileNum,
        ));
      } else {
        emit(ForgetPasswordErrorState(
            response?.message ?? 'Something went wrong'));
      }
    } catch (e) {
      emit(ForgetPasswordErrorState(
          e.toString().replaceFirst('Exception: ', '')));
    }
  }

  // ─── Verify OTP ────────────────────────────────────────────────────────────
  Future<void> _onVerifyOtp(
    VerifyForgetPasswordOtpEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(const ForgetPasswordOtpVerifyingState());

    try {
      final result = await _authRepository.verifyOTP(
        channel: _channel ?? 'phone',
        destination: _destination ?? _mobileNum ?? '',
        verificationUid: _verificationUid ?? '',
        otp: event.otp,
        purpose: _purpose ?? 'guruji_forgot_password',
      );

      if (result != null &&
          (result.success == true || result.data?.verified == true)) {
        // Store token so reset password can use it
        _verificationToken = result.data?.verificationToken;
        if (result.data?.verificationUid != null &&
            result.data!.verificationUid!.isNotEmpty) {
          _verificationUid = result.data!.verificationUid;
        }

        emit(ForgetPasswordOtpVerifiedState(
          verificationToken: _verificationToken,
          verificationUid: _verificationUid,
          mobileNum: _mobileNum ?? '',
        ));
      } else {
        emit(const ForgetPasswordErrorState('Invalid OTP. Please try again.'));
      }
    } catch (e) {
      emit(ForgetPasswordErrorState(
          e.toString().replaceFirst('Exception: ', '')));
    }
  }

  // ─── Resend OTP ────────────────────────────────────────────────────────────
  Future<void> _onResendOtp(
    ResendForgetPasswordOtpEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    if (_mobileNum == null) return;

    try {
      final response = await _authRepository.forgetPassfunction(
        _mobileNum!,
        _purpose ?? 'guruji_forgot_password',
      );

      if (response != null && response.success == true) {
        _verificationUid = response.verification?.verificationUid ??
            response.data?.verification?.verificationUid;
        _channel = response.verification?.channel ??
            response.data?.verification?.channel ??
            'phone';
        _destination = response.verification?.destination ??
            response.data?.verification?.destination ??
            _mobileNum;
        _purpose = response.verification?.purpose ??
            response.data?.verification?.purpose ??
            _purpose;

        emit(const ForgetPasswordOtpResentState());
      } else {
        emit(ForgetPasswordErrorState(
            response?.message ?? 'Failed to resend OTP'));
      }
    } catch (e) {
      emit(ForgetPasswordErrorState(
          e.toString().replaceFirst('Exception: ', '')));
    }
  }

  // ─── Reset Password ────────────────────────────────────────────────────────
  Future<void> _onResetPasswordSubmit(
    ResetPasswordSubmitEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(const ResetPasswordLoadingState());

    try {
      final result = await _authRepository.resetPasswordFunction(
        phone: event.phone.isNotEmpty ? event.phone : (_mobileNum ?? ''),
        verificationUid: event.verificationUid.isNotEmpty
            ? event.verificationUid
            : (_verificationUid ?? ''),
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
        purpose: event.purpose,
        verificationToken:
            event.verificationToken ?? _verificationToken,
      );

      if (result != null && result['success'] == true) {
        emit(ResetPasswordSuccessState(
          result['message']?.toString() ??
              'Your password has been reset successfully.',
        ));
      } else {
        emit(ResetPasswordErrorState(
          result?['message']?.toString() ?? 'Failed to reset password.',
        ));
      }
    } catch (e) {
      emit(ResetPasswordErrorState(
          e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
