import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:purohitset_app/Constant/api_endpoint.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/send_OTP_model.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/verify_otp_model.dart';
import 'package:purohitset_app/Yajaman_Side/Model/Auth/yajaman_register_model.dart';

class YajamanAuthRepository {
  final Dio dio = Dio();

  // Yajaman Registration
  Future<YajamanRegisterModel?> registerYajaman({
    required String name,
    required String phone,
    required String whatsappNumber,
    required String email,
    required String address,
    required String city,
    required String pincode,
    required String password,
    String? phoneVerificationUid,
    String? phoneVerificationToken,
    String otpPurpose = "yajaman_registration",
  }) async {
    final registerApi = ApiEndpoint().hostUrl + ApiEndpoint().yajamanRegApi;

    debugPrint("========================================");
    debugPrint("YAJAMAN REGISTER API: $registerApi");

    final requestData = {
      "name": name,
      "phone": phone,
      "mobile": phone,
      "whatsapp_number": whatsappNumber,
      "email": email,
      "address": address,
      "city": city,
      "pincode": pincode,
      "password": password,
      "phone_verification_uid": phoneVerificationUid ?? "",
      "phone_verification_token": phoneVerificationToken ?? "",
      "otp_purpose": otpPurpose,
      "role": "yajaman",
    };

    debugPrint("YAJAMAN REGISTER REQUEST: ${jsonEncode(requestData)}");

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

      debugPrint("YAJAMAN REGISTER STATUS: ${response.statusCode}");
      debugPrint("YAJAMAN REGISTER RESPONSE: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map) {
          final data = response.data as Map;
          if (data['success'] == false) {
            final msg = data['message'] ?? 'Registration failed';
            throw Exception(msg.toString());
          }
          return YajamanRegisterModel.fromJson(Map<String, dynamic>.from(data));
        }
        return YajamanRegisterModel(name: name, phone: phone);
      }
      throw Exception("Registration failed with status: ${response.statusCode}");
    } on DioException catch (e) {
      debugPrint("Yajaman Register Dio Error: ${e.response?.data}");
      final responseData = e.response?.data;
      if (responseData is Map && responseData['message'] != null) {
        throw Exception(responseData['message'].toString());
      }
      throw Exception(e.message ?? "Registration failed. Please try again.");
    } catch (e) {
      debugPrint("Unexpected Yajaman Register Error: $e");
      rethrow;
    }
  }

  // Send OTP
  Future<SendOTPModel?> sendOTP(
    String destination,
    String purpose,
    String channel,
  ) async {
    final sendOtpApi = ApiEndpoint().hostUrl + ApiEndpoint().sendOTP;

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SendOTPModel.fromJson(response.data);
      }
      throw Exception('OTP failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      final responseData = e.response?.data;
      if (responseData is Map && responseData["message"] != null) {
        throw Exception(responseData["message"].toString());
      }
      throw Exception(e.message ?? 'Failed to send OTP');
    }
  }

  // Verify OTP
  Future<VerifyOTPModel?> verifyOTP({
    required String channel,
    required String destination,
    required String verificationUid,
    required String otp,
    String purpose = "yajaman_registration",
  }) async {
    final verifyOtpApi = ApiEndpoint().hostUrl + ApiEndpoint().verifyOTP;

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
      final responseData = e.response?.data;
      if (responseData is Map && responseData["message"] != null) {
        throw Exception(responseData["message"].toString());
      }
      throw Exception(e.message ?? 'Failed to verify OTP');
    }
  }
}
