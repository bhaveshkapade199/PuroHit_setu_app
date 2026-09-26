import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';
import 'register_state.dart';

import 'package:purohitset_app/Repository/Auth/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(const RegisterInitialState()) {
    // =========================
    // Dropdown Events
    // =========================

    on<GenderChangedEvent>(_onGenderChanged);
    on<ReligionChangedEvent>(_onReligionChanged);
    on<SampradayChangedEvent>(_onSampradayChanged);
    on<VedaShakhaChangedEvent>(_onVedaShakhaChanged);

    // =========================
    // WhatsApp
    // =========================

    on<WhatsappSameAsPhoneChangedEvent>(_onWhatsappSameAsPhoneChanged);

    // =========================
    // Phone OTP
    // =========================

    on<SendPhoneOtpEvent>(_onSendPhoneOtp);
    on<VerifyPhoneOtpEvent>(_onVerifyPhoneOtp);

    // =========================
    // Email OTP
    // =========================

    on<SendEmailOtpEvent>(_onSendEmailOtp);
    on<VerifyEmailOtpEvent>(_onVerifyEmailOtp);

    // =========================
    // Register
    // =========================

    on<RegisterUserEvent>(_onRegisterUser);

    on<PasswordVisibilityEvent>(_onPasswordVisibilityChanged);
  }

  // =====================================================
  // Gender
  // =====================================================

  void _onGenderChanged(GenderChangedEvent event, Emitter<RegisterState> emit) {
    debugPrint("BLOC GENDER = [${event.gender}]");

    emit(
      RegisterInitialState(
        gender: event.gender,
        religion: state.religion,
        sampraday: state.sampraday,
        vedaShakha: state.vedaShakha,
        isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

        phoneOtpSent: state.phoneOtpSent,
        phoneVerified: state.phoneVerified,

        emailOtpSent: state.emailOtpSent,
        emailVerified: state.emailVerified,
      ),
    );
  }

  // =====================================================
  // Religion
  // =====================================================

  void _onReligionChanged(
    ReligionChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    debugPrint("BLOC RELIGION = [${event.religion}]");

    emit(
      RegisterInitialState(
        gender: state.gender,
        religion: event.religion,
        sampraday: state.sampraday,
        vedaShakha: state.vedaShakha,
        isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

        phoneOtpSent: state.phoneOtpSent,
        phoneVerified: state.phoneVerified,

        emailOtpSent: state.emailOtpSent,
        emailVerified: state.emailVerified,
      ),
    );
  }

  // =====================================================
  // Sampraday
  // =====================================================

  void _onSampradayChanged(
    SampradayChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    debugPrint("BLOC SAMPRADAY = [${event.sampraday}]");

    emit(
      RegisterInitialState(
        gender: state.gender,
        religion: state.religion,
        sampraday: event.sampraday,
        vedaShakha: state.vedaShakha,
        isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

        phoneOtpSent: state.phoneOtpSent,
        phoneVerified: state.phoneVerified,

        emailOtpSent: state.emailOtpSent,
        emailVerified: state.emailVerified,
      ),
    );
  }

  // =====================================================
  // Veda Shakha
  // =====================================================

  void _onVedaShakhaChanged(
    VedaShakhaChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    debugPrint("BLOC VEDA SHAKHA = [${event.vedaShakha}]");

    emit(
      RegisterInitialState(
        gender: state.gender,
        religion: state.religion,
        sampraday: state.sampraday,
        vedaShakha: event.vedaShakha,
        isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

        phoneOtpSent: state.phoneOtpSent,
        phoneVerified: state.phoneVerified,

        emailOtpSent: state.emailOtpSent,
        emailVerified: state.emailVerified,
      ),
    );
  }

  // =====================================================
  // WhatsApp
  // =====================================================

  void _onWhatsappSameAsPhoneChanged(
    WhatsappSameAsPhoneChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterInitialState(
        gender: state.gender,
        religion: state.religion,
        sampraday: state.sampraday,
        vedaShakha: state.vedaShakha,

        isWhatsappSameAsPhone: event.isSame,

        phoneOtpSent: state.phoneOtpSent,
        phoneVerified: state.phoneVerified,

        emailOtpSent: state.emailOtpSent,
        emailVerified: state.emailVerified,
      ),
    );
  }

  // =====================================================
  // SEND PHONE OTP
  // =====================================================

  Future<void> _onSendPhoneOtp(
    SendPhoneOtpEvent event,
    Emitter<RegisterState> emit,
  ) async {
    debugPrint("Sending Phone OTP...");

    try {
      await Future.delayed(const Duration(seconds: 1));

      debugPrint("Phone OTP Sent Successfully");

      emit(
        RegisterInitialState(
          gender: state.gender,
          religion: state.religion,
          sampraday: state.sampraday,
          vedaShakha: state.vedaShakha,
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

          phoneOtpSent: true,
          phoneVerified: false,

          emailOtpSent: state.emailOtpSent,
          emailVerified: state.emailVerified,
        ),
      );
    } catch (e) {
      debugPrint("Phone OTP Error: $e");

      emit(
        RegisterErrorState(
          errorMessage: "Failed to send phone OTP",

          gender: state.gender,
          religion: state.religion,
          sampraday: state.sampraday,
          vedaShakha: state.vedaShakha,
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

          phoneOtpSent: false,
          phoneVerified: false,

          emailOtpSent: state.emailOtpSent,
          emailVerified: state.emailVerified,
        ),
      );
    }
  }

  // =====================================================
  // VERIFY PHONE OTP
  // =====================================================

  Future<void> _onVerifyPhoneOtp(
    VerifyPhoneOtpEvent event,
    Emitter<RegisterState> emit,
  ) async {
    debugPrint("VERIFY PHONE OTP = [${event.otp}]");

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Temporary example
      if (event.otp.length == 6) {
        debugPrint("Phone OTP Verified");

        emit(
          RegisterInitialState(
            gender: state.gender,
            religion: state.religion,
            sampraday: state.sampraday,
            vedaShakha: state.vedaShakha,
            isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

            phoneOtpSent: true,
            phoneVerified: true,

            emailOtpSent: state.emailOtpSent,
            emailVerified: state.emailVerified,
          ),
        );
      } else {
        throw Exception("Invalid OTP");
      }
    } catch (e) {
      emit(
        RegisterErrorState(
          errorMessage: "Invalid phone OTP",

          gender: state.gender,
          religion: state.religion,
          sampraday: state.sampraday,
          vedaShakha: state.vedaShakha,
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

          phoneOtpSent: true,
          phoneVerified: false,

          emailOtpSent: state.emailOtpSent,
          emailVerified: state.emailVerified,
        ),
      );
    }
  }

  // =====================================================
  // SEND EMAIL OTP
  // =====================================================

  Future<void> _onSendEmailOtp(
    SendEmailOtpEvent event,
    Emitter<RegisterState> emit,
  ) async {
    debugPrint("Sending Email OTP...");

    try {
      await Future.delayed(const Duration(seconds: 1));

      debugPrint("Email OTP Sent Successfully");

      emit(
        RegisterInitialState(
          gender: state.gender,
          religion: state.religion,
          sampraday: state.sampraday,
          vedaShakha: state.vedaShakha,
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

          phoneOtpSent: state.phoneOtpSent,
          phoneVerified: state.phoneVerified,

          emailOtpSent: true,
          emailVerified: false,
        ),
      );
    } catch (e) {
      emit(
        RegisterErrorState(
          errorMessage: "Failed to send email OTP",

          gender: state.gender,
          religion: state.religion,
          sampraday: state.sampraday,
          vedaShakha: state.vedaShakha,
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

          phoneOtpSent: state.phoneOtpSent,
          phoneVerified: state.phoneVerified,

          emailOtpSent: false,
          emailVerified: false,
        ),
      );
    }
  }

  // =====================================================
  // VERIFY EMAIL OTP
  // =====================================================

  Future<void> _onVerifyEmailOtp(
    VerifyEmailOtpEvent event,
    Emitter<RegisterState> emit,
  ) async {
    debugPrint("VERIFY EMAIL OTP = [${event.otp}]");

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (event.otp.length == 6) {
        debugPrint("Email OTP Verified");

        emit(
          RegisterInitialState(
            gender: state.gender,
            religion: state.religion,
            sampraday: state.sampraday,
            vedaShakha: state.vedaShakha,
            isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

            phoneOtpSent: state.phoneOtpSent,
            phoneVerified: state.phoneVerified,

            emailOtpSent: true,
            emailVerified: true,
          ),
        );
      } else {
        throw Exception("Invalid OTP");
      }
    } catch (e) {
      emit(
        RegisterErrorState(
          errorMessage: "Invalid email OTP",

          gender: state.gender,
          religion: state.religion,
          sampraday: state.sampraday,
          vedaShakha: state.vedaShakha,
          isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

          phoneOtpSent: state.phoneOtpSent,
          phoneVerified: state.phoneVerified,

          emailOtpSent: true,
          emailVerified: false,
        ),
      );
    }
  }

  void _onPasswordVisibilityChanged(
    PasswordVisibilityEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterInitialState(
        gender: state.gender,
        religion: state.religion,
        sampraday: state.sampraday,
        vedaShakha: state.vedaShakha,

        isWhatsappSameAsPhone: state.isWhatsappSameAsPhone,

        phoneOtpSent: state.phoneOtpSent,
        phoneVerified: state.phoneVerified,

        emailOtpSent: state.emailOtpSent,
        emailVerified: state.emailVerified,

        isPasswordVisible: event.isVisible,
      ),
    );
  }

  // =====================================================
  // REGISTER USER
  // =====================================================

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final currentState = state;

    debugPrint("========== REGISTER BLOC VALUES ==========");

    debugPrint("Gender: ${currentState.gender}");

    debugPrint("Religion: ${currentState.religion}");

    debugPrint("Sampraday: ${currentState.sampraday}");

    debugPrint("Veda Shakha: ${currentState.vedaShakha}");

    debugPrint("Language: ${event.languagePreference}");

    debugPrint("Phone Verified: ${currentState.phoneVerified}");

    debugPrint("Email Verified: ${currentState.emailVerified}");

    debugPrint("==========================================");

    // Don't allow registration without verification

    if (!currentState.phoneVerified) {
      emit(
        RegisterErrorState(
          errorMessage: "Please verify your phone number first.",

          gender: currentState.gender,
          religion: currentState.religion,
          sampraday: currentState.sampraday,
          vedaShakha: currentState.vedaShakha,
          isWhatsappSameAsPhone: currentState.isWhatsappSameAsPhone,

          phoneOtpSent: currentState.phoneOtpSent,
          phoneVerified: currentState.phoneVerified,

          emailOtpSent: currentState.emailOtpSent,
          emailVerified: currentState.emailVerified,
        ),
      );

      return;
    }

    if (!currentState.emailVerified) {
      emit(
        RegisterErrorState(
          errorMessage: "Please verify your email first.",

          gender: currentState.gender,
          religion: currentState.religion,
          sampraday: currentState.sampraday,
          vedaShakha: currentState.vedaShakha,
          isWhatsappSameAsPhone: currentState.isWhatsappSameAsPhone,

          phoneOtpSent: currentState.phoneOtpSent,
          phoneVerified: currentState.phoneVerified,

          emailOtpSent: currentState.emailOtpSent,
          emailVerified: currentState.emailVerified,
        ),
      );

      return;
    }

    emit(
      RegisterLoadingState(
        gender: currentState.gender,
        religion: currentState.religion,
        sampraday: currentState.sampraday,
        vedaShakha: currentState.vedaShakha,
        isWhatsappSameAsPhone: currentState.isWhatsappSameAsPhone,

        phoneOtpSent: currentState.phoneOtpSent,
        phoneVerified: currentState.phoneVerified,

        emailOtpSent: currentState.emailOtpSent,
        emailVerified: currentState.emailVerified,
      ),
    );

    try {
      final response = await authRepository.register(
        firstName: event.firstName,
        middleName: event.middleName,
        lastName: event.lastName,

        gender: currentState.gender,

        dateOfBirth: event.dateOfBirth,

        phone: event.phone,
        alternatePhone: event.alternatePhone,
        whatsappNumber: event.whatsappNumber,

        email: event.email,
        password: event.password,

        bio: event.bio,

        religion: currentState.religion,
        sampraday: currentState.sampraday,
        vedaShakha: currentState.vedaShakha,

        qualification: event.qualification,
        experienceYears: event.experienceYears,

        languagePreference: event.languagePreference,
      );

      if (response != null) {
        emit(
          RegisterLoadedState(
            response: response,

            gender: currentState.gender,
            religion: currentState.religion,
            sampraday: currentState.sampraday,
            vedaShakha: currentState.vedaShakha,
            isWhatsappSameAsPhone: currentState.isWhatsappSameAsPhone,

            phoneOtpSent: currentState.phoneOtpSent,
            phoneVerified: currentState.phoneVerified,

            emailOtpSent: currentState.emailOtpSent,
            emailVerified: currentState.emailVerified,
          ),
        );
      } else {
        emit(
          RegisterErrorState(
            errorMessage: "Registration failed.",

            gender: currentState.gender,
            religion: currentState.religion,
            sampraday: currentState.sampraday,
            vedaShakha: currentState.vedaShakha,
            isWhatsappSameAsPhone: currentState.isWhatsappSameAsPhone,

            phoneOtpSent: currentState.phoneOtpSent,
            phoneVerified: currentState.phoneVerified,

            emailOtpSent: currentState.emailOtpSent,
            emailVerified: currentState.emailVerified,
          ),
        );
      }
    } catch (e) {
      emit(
        RegisterErrorState(
          errorMessage: e.toString().replaceFirst("Exception: ", ""),

          gender: currentState.gender,
          religion: currentState.religion,
          sampraday: currentState.sampraday,
          vedaShakha: currentState.vedaShakha,
          isWhatsappSameAsPhone: currentState.isWhatsappSameAsPhone,

          phoneOtpSent: currentState.phoneOtpSent,
          phoneVerified: currentState.phoneVerified,

          emailOtpSent: currentState.emailOtpSent,
          emailVerified: currentState.emailVerified,
        ),
      );
    }
  }
}
