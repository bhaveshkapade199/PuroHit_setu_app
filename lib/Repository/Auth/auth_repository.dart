import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:purohitset_app/Model/Auth/guruji_login_model.dart';
import 'package:purohitset_app/Model/Auth/guruji_register_model.dart';
import 'package:purohitset_app/Constant/api_endpoint.dart';

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
    required String alternatePhone,
    required String whatsappNumber,
    required String email,
    required String password,
    required String bio,
    required String religion,
    required String sampraday,
    required String vedaShakha,
    required String qualification,
    required int experienceYears,
    required String languagePreference,
  }) async {
    final registerApi = ApiEndpoint().BaseUrl + ApiEndpoint().GurujiRegApi;

    debugPrint("========================================");
    debugPrint("REGISTER API: $registerApi");

    final requestData = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "phone": phone,
      "alternate_phone": alternatePhone,
      "whatsapp_number": whatsappNumber,
      "email": email,
      "password": password,
      "bio": bio,
      "religion": religion,
      "sampraday": sampraday,
      "veda_shakha": vedaShakha,
      "qualification": qualification,
      "experience_years": experienceYears,
      "language_preference": languagePreference,
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
    final loginApi = ApiEndpoint().BaseUrl + ApiEndpoint().GurujiLogin;

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
}
