import 'dart:developer';

import 'package:auth_implementation/Utils/API_Utils/api_end_points.dart';
import 'package:auth_implementation/Utils/API_Utils/api_exception.dart';
import 'package:dio/dio.dart';

class PasswordService {
  final Dio _dio;
  PasswordService(this._dio);

  Future<Map<String, dynamic>> changePassword({
    required String accessToken,
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await _dio.put(
        ApiEndPoints.changePassword,
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "confirm_new_password": confirmNewPassword,
        },

        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      log(response.data['message']);
      log("---- above is response of change password.");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String accessToken,
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndPoints.resetPassword,
        data: {"email": email},

        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      log(response.data['message']);
      log("---- above is response of change password.");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('STATUS: ${e.response?.statusCode}');
      log('DATA: ${e.response?.data}');
      log('HEADERS: ${e.response?.headers}');
      log('MESSAGE: ${e.message}');
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> otpResetPassword({
    required String accessToken,
    required String email,
    required String otp,
    required String password,
    required String confirmpassword,
  }) async {
    try {
      final response = await _dio.put(
        ApiEndPoints.otpResetPassword,
        data: {
          "email": email,
          "otp": otp,
          "password": password,
          "confirm_password": confirmpassword,
        },

        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      log(response.data['message']);
      log("---- above is response of change password.");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('STATUS: ${e.response?.statusCode}');
      log('DATA: ${e.response?.data}');
      log('HEADERS: ${e.response?.headers}');
      log('MESSAGE: ${e.message}');
      throw ApiException.fromDioError(e);
    }
  }
}
