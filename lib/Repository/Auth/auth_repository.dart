import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:purohitset_app/Model/Auth/forget_password_model.dart';
import 'package:purohitset_app/Model/Auth/guruji_login_model.dart';
import 'package:purohitset_app/Model/Auth/guruji_register_model.dart';
import 'package:purohitset_app/Constant/api_endpoint.dart';
import 'package:purohitset_app/Model/Auth/send_OTP_model.dart';
import 'package:purohitset_app/Model/Auth/verify_otp_model.dart';

class AuthRepository {
  final Dio dio = Dio();

  // Create the Function for the Register

  Future<GurujiRegisterModel?> register({
    required String firstName,
    required String middleName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
    required String phone,
    required String whatsappNumber,
    required String email,
    required String password,
    required String religion,
    required String sampraday,
    required String vedaShakha,
    String? phoneVerificationUid,
    String? emailVerificationUid,
    String? phoneVerificationToken,
    String? emailVerificationToken,
    String otpPurpose = "guruji_registration",
  }) async {
    final registerApi = ApiEndpoint().baseUrl + ApiEndpoint().gurujiRegApi;

    debugPrint("========================================");
    debugPrint("REGISTER API: $registerApi");

    final requestData = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "phone": phone,
      "whatsapp_number": whatsappNumber,
      "email": email,
      "password": password,
      "religion": religion,
      "sampraday": sampraday,
      "veda_shakha": vedaShakha,
      "phone_verification_uid": phoneVerificationUid ?? "",
      "email_verification_uid": emailVerificationUid ?? "",
      "phone_verification_token": phoneVerificationToken ?? "",
      "email_verification_token": emailVerificationToken ?? "",
      "otp_purpose": otpPurpose,
    };

    debugPrint("REGISTER REQUEST:");
    debugPrint(jsonEncode(requestData));

    try {
      final response = await dio.post(
        registerApi,
        data: requestData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      debugPrint("REGISTER STATUS CODE: ${response.statusCode}");
      debugPrint("REGISTER RESPONSE: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return GurujiRegisterModel.fromJson(response.data);
      }

      throw Exception(
        "Registration failed. Status code: ${response.statusCode}",
      );
    } on DioException catch (e) {
      debugPrint("========================================");
      debugPrint("DIO ERROR");
      debugPrint("Type: ${e.type}");
      debugPrint("Message: ${e.message}");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Response: ${e.response?.data}");
      debugPrint("Request URL: ${e.requestOptions.uri}");
      debugPrint("Request Data: ${e.requestOptions.data}");
      debugPrint("========================================");

      final responseData = e.response?.data;

      if (responseData is Map) {
        final message = responseData["message"];
        final errors = responseData["errors"];

        debugPrint("API Message: $message");
        debugPrint("API Validation Errors: $errors");

        throw Exception(message?.toString() ?? "Registration failed");
      }

      throw Exception(e.message ?? "Registration failed");
    } catch (e) {
      debugPrint("Unexpected Registration Error: $e");

      throw Exception("Something went wrong during registration.");
    }
  }
  //Create the function for the login

  Future<GurujiLoginModel?> login(String phoneNum, String password) async {
    final loginApi = ApiEndpoint().baseUrl + ApiEndpoint().gurujiLogin;

    debugPrint('Login API: $loginApi');

    try {
      final response = await dio.post(
        loginApi,
        data: {'phone': phoneNum, 'password': password},
      );

      debugPrint('Login Response Code: ${response.statusCode}');
      debugPrint('Login Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return GurujiLoginModel.fromJson(response.data);
      }

      throw Exception('Login failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      debugPrint('Dio Error Type: ${e.type}');
      debugPrint('Dio Error Message: ${e.message}');
      debugPrint('Status Code: ${e.response?.statusCode}');
      debugPrint('Response: ${e.response?.data}');

      // Don't convert network errors into "invalid credentials".
      rethrow;
    } catch (e) {
      debugPrint('Unexpected Login Error: $e');
      rethrow;
    }
  }

  // Create the function for sending OTP (phone or email)
  Future<SendOTPModel?> sendOTP(
    String channel,
    String destination, {
    String purpose = "guruji_registration",
  }) async {
    final sendOtpApi = ApiEndpoint().hostUrl + ApiEndpoint().sendOTP;

    debugPrint("Send OTP Api is : $sendOtpApi");

    try {
      final response = await dio.post(
        sendOtpApi,
        data: {
          "channel": channel,
          "destination": destination,
          "purpose": purpose,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      debugPrint("Send OTP Response Code: ${response.statusCode}");
      debugPrint("Send OTP Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SendOTPModel.fromJson(response.data);
      }

      throw Exception('OTP failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      debugPrint('Dio Error Type: ${e.type}');
      debugPrint('Dio Error Message: ${e.message}');
      debugPrint('Status Code: ${e.response?.statusCode}');
      debugPrint('Response: ${e.response?.data}');

      final responseData = e.response?.data;
      if (responseData is Map && responseData["message"] != null) {
        throw Exception(responseData["message"].toString());
      }
      throw Exception(e.message ?? 'Failed to send OTP');
    } catch (e) {
      debugPrint('Unexpected OTP Send Error: $e');
      rethrow;
    }
  }

  // Create the function for verifying OTP (phone or email)
  Future<VerifyOTPModel?> verifyOTP({
    required String channel,
    required String destination,
    required String verificationUid,
    required String otp,
    String purpose = "guruji_registration",
  }) async {
    final verifyOtpApi = ApiEndpoint().hostUrl + ApiEndpoint().verifyOTP;

    debugPrint("Verify OTP Api: $verifyOtpApi");

    try {
      final response = await dio.post(
        verifyOtpApi,
        data: {
          "channel": channel,
          "destination": destination,
          "verification_uid": verificationUid,
          "otp": otp,
          "purpose": purpose,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      debugPrint("Verify OTP Response Code: ${response.statusCode}");
      debugPrint("Verify OTP Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map) {
          final model = VerifyOTPModel.fromJson(response.data);
          if (model.success == true || model.data?.verified == true) {
            return model;
          }
        }
      }

      return null;
    } on DioException catch (e) {
      debugPrint('Dio Error Type: ${e.type}');
      debugPrint('Dio Error Message: ${e.message}');
      debugPrint('Status Code: ${e.response?.statusCode}');
      debugPrint('Response: ${e.response?.data}');

      final responseData = e.response?.data;
      if (responseData is Map && responseData["message"] != null) {
        throw Exception(responseData["message"].toString());
      }
      throw Exception(e.message ?? 'Failed to verify OTP');
    } catch (e) {
      debugPrint('Unexpected OTP Verify Error: $e');
      rethrow;
    }
  }

  // Create the funtion for the Forget Password model

  Future<ForgetPasswordModel?> forgetPassfunction(
    String mobilenum,
    String purpose,
  ) async {
    final forgetPassApi = ApiEndpoint().hostUrl + ApiEndpoint().forgetPassword;

    debugPrint("Forget Password API: $forgetPassApi");

    try {
      final response = await dio.post(
        forgetPassApi,
        data: {"mobile": mobilenum, "otp_purpose": purpose},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      debugPrint("Forget Password Response Code: ${response.statusCode}");

      debugPrint("Forget Password Response: ${response.data}");

      if (response.statusCode == 200) {
        final result = ForgetPasswordModel.fromJson(response.data);

        return result;
      }

      return null;
    } on DioException catch (e) {
      debugPrint('Dio Error Type: ${e.type}');
      debugPrint('Dio Error Message: ${e.message}');
      debugPrint('Status Code: ${e.response?.statusCode}');
      debugPrint('Response: ${e.response?.data}');

      final responseData = e.response?.data;

      if (responseData is Map && responseData["message"] != null) {
        throw Exception(responseData["message"].toString());
      }

      throw Exception(e.message ?? 'Failed to send forgot password OTP');
    } catch (e) {
      debugPrint('Unexpected Forget Password Error: $e');

      rethrow;
    }
  }
}
