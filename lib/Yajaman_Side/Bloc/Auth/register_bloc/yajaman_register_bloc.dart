import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Repository/Yajaman_Auth_Repo/yajaman_auth_repository.dart';
import 'package:purohitset_app/Yajaman_Side/Bloc/Auth/register_bloc/yajaman_register_event.dart';
import 'package:purohitset_app/Yajaman_Side/Bloc/Auth/register_bloc/yajaman_register_state.dart';

class YajamanRegisterBloc
    extends Bloc<YajamanRegisterEvent, YajamanRegisterState> {
  final YajamanAuthRepository authRepository;

  YajamanRegisterBloc(this.authRepository)
      : super(const YajamanRegisterInitialState()) {
    // WhatsApp same as phone toggle
    on<YajamanWhatsappSameAsPhoneChangedEvent>((event, emit) {
      emit(
        YajamanRegisterInitialState(
          isWhatsappSameAsPhone: event.isSame,
          isPasswordVisible: state.isPasswordVisible,
          phoneOtpSent: state.phoneOtpSent,
          phoneVerified: state.phoneVerified,
          phoneVerificationUid: state.phoneVerificationUid,
          phoneVerificationToken: state.phoneVerificationToken,
        ),
      );
    });

    // Password visibility toggle
    on<YajamanPasswordVisibilityEvent>((event, emit) {
      emit(
        YajamanRegisterInitialState(
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
          isPasswordVisible: event.isVisible,
          phoneOtpSent: state.phoneOtpSent,
          phoneVerified: state.phoneVerified,
          phoneVerificationUid: state.phoneVerificationUid,
          phoneVerificationToken: state.phoneVerificationToken,
        ),
      );
    });

    // Send Phone OTP
    on<YajamanSendPhoneOtpEvent>((event, emit) async {
      try {
        final phone = event.phone.trim();
        final otpResponse = await authRepository.sendOTP(
          phone,
          "yajaman_registration",
          "sms",
        );

        if (otpResponse != null && otpResponse.success == true) {
          final uid = otpResponse.data?.verificationUid ?? "";
          emit(
            YajamanRegisterInitialState(
              isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
              isPasswordVisible: state.isPasswordVisible,
              phoneOtpSent: true,
              phoneVerified: false,
              phoneVerificationUid: uid,
              phoneVerificationToken: "",
            ),
          );
        } else {
          emit(
            YajamanRegisterErrorState(
              errorMessage:
                  otpResponse?.message ?? "Failed to send OTP to phone",
              isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
              isPasswordVisible: state.isPasswordVisible,
              phoneOtpSent: false,
              phoneVerified: false,
            ),
          );
        }
      } catch (e) {
        emit(
          YajamanRegisterErrorState(
            errorMessage: e.toString().replaceFirst("Exception: ", ""),
            isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
            isPasswordVisible: state.isPasswordVisible,
            phoneOtpSent: false,
            phoneVerified: false,
          ),
        );
      }
    });

    // Verify Phone OTP
    on<YajamanVerifyPhoneOtpEvent>((event, emit) async {
      try {
        final otp = event.otp.trim();
        final phone = event.phone.trim();

        final verifyResponse = await authRepository.verifyOTP(
          channel: "sms",
          destination: phone,
          verificationUid: state.phoneVerificationUid,
          otp: otp,
          purpose: "yajaman_registration",
        );

        if (verifyResponse != null &&
            (verifyResponse.success == true ||
                verifyResponse.data?.verified == true)) {
          final token = verifyResponse.data?.verificationToken ?? "";
          emit(
            YajamanRegisterInitialState(
              isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
              isPasswordVisible: state.isPasswordVisible,
              phoneOtpSent: true,
              phoneVerified: true,
              phoneVerificationUid: state.phoneVerificationUid,
              phoneVerificationToken: token,
            ),
          );
        } else {
          emit(
            YajamanRegisterErrorState(
              errorMessage:
                  verifyResponse?.message ?? "Invalid phone OTP. Try again.",
              isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
              isPasswordVisible: state.isPasswordVisible,
              phoneOtpSent: state.phoneOtpSent,
              phoneVerified: false,
              phoneVerificationUid: state.phoneVerificationUid,
            ),
          );
        }
      } catch (e) {
        emit(
          YajamanRegisterErrorState(
            errorMessage: e.toString().replaceFirst("Exception: ", ""),
            isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
            isPasswordVisible: state.isPasswordVisible,
            phoneOtpSent: state.phoneOtpSent,
            phoneVerified: false,
            phoneVerificationUid: state.phoneVerificationUid,
          ),
        );
      }
    });

    // Form Submit
    on<YajamanRegisterSubmitEvent>((event, emit) async {
      emit(
        YajamanRegisterLoadingState(
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
          isPasswordVisible: state.isPasswordVisible,
          phoneOtpSent: state.phoneOtpSent,
          phoneVerified: state.phoneVerified,
          phoneVerificationUid: state.phoneVerificationUid,
          phoneVerificationToken: state.phoneVerificationToken,
        ),
      );

      try {
        final result = await authRepository.registerYajaman(
          name: event.name,
          phone: event.phone,
          whatsappNumber: event.whatsappNumber,
          email: event.email,
          address: event.address,
          city: event.city,
          pincode: event.pincode,
          password: event.password,
          phoneVerificationUid: state.phoneVerificationUid,
          phoneVerificationToken: state.phoneVerificationToken,
        );

        if (result != null) {
          emit(
            YajamanRegisterLoadedState(
              response: result,
              isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
              isPasswordVisible: state.isPasswordVisible,
              phoneOtpSent: state.phoneOtpSent,
              phoneVerified: state.phoneVerified,
              phoneVerificationUid: state.phoneVerificationUid,
              phoneVerificationToken: state.phoneVerificationToken,
            ),
          );
        } else {
          emit(
            YajamanRegisterErrorState(
              errorMessage: "Registration failed. Please try again.",
              isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
              isPasswordVisible: state.isPasswordVisible,
              phoneOtpSent: state.phoneOtpSent,
              phoneVerified: state.phoneVerified,
              phoneVerificationUid: state.phoneVerificationUid,
              phoneVerificationToken: state.phoneVerificationToken,
            ),
          );
        }
      } on DioException catch (e) {
        String message = "Registration failed";
        final data = e.response?.data;
        if (data is Map && data['message'] != null) {
          message = data['message'].toString();
        } else if (e.message != null) {
          message = e.message!;
        }
        emit(
          YajamanRegisterErrorState(
            errorMessage: message,
            isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
            isPasswordVisible: state.isPasswordVisible,
            phoneOtpSent: state.phoneOtpSent,
            phoneVerified: state.phoneVerified,
            phoneVerificationUid: state.phoneVerificationUid,
            phoneVerificationToken: state.phoneVerificationToken,
          ),
        );
      } catch (e) {
        emit(
          YajamanRegisterErrorState(
            errorMessage: e.toString().replaceFirst("Exception: ", ""),
            isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,
            isPasswordVisible: state.isPasswordVisible,
            phoneOtpSent: state.phoneOtpSent,
            phoneVerified: state.phoneVerified,
            phoneVerificationUid: state.phoneVerificationUid,
            phoneVerificationToken: state.phoneVerificationToken,
          ),
        );
      }
    });
  }
}
