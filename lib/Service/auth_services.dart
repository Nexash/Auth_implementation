import 'dart:developer';

import 'package:auth_implementation/Modal/Login/Request/login_modal.dart';
import 'package:auth_implementation/Modal/Register/register_modal.dart';
import 'package:auth_implementation/Utils/API_Utils/api_end_points.dart';
import 'package:auth_implementation/Utils/API_Utils/api_exception.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio;
  AuthService(this._dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final loginData = LoginModal(email: email, password: password);
      final response = await _dio.post(
        ApiEndPoints.login,
        data: loginData.toJson(),
        options: Options(extra: {'requiresToken': false}),
      );

      log("------------------Login API Response1: ${response.data}");
      log("------------------Login API Response2: ${response.statusCode}");

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException("Something went wrong.");
    }
  }

  // REGISTER
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String confirmPassword,
    String username,
    String firstName,
    String lastName,
  ) async {
    try {
      final registerdata = RegisterModal(
        email: email,
        username: username,
        password: password,
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
      );
      final response = await _dio.post(
        ApiEndPoints.register,
        data: registerdata.toJson(),
        options: Options(extra: {'requiresToken': false}),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> userData(String accesstokens) async {
    try {
      final response = await _dio.get(
        ApiEndPoints.userData,

        options: Options(headers: {'Authorization': 'Bearer $accesstokens'}),
      );
      log("------------------UserData fetch API Response: ${response.data}");
      log("------------------UserData fetch status:${response.statusCode}");

      return response.data;
    } on DioException catch (e) {
      log("********_____${e.toString()}");
      throw ApiException.fromDioError(e);
    } catch (e) {
      log(e.toString());
      throw ApiException("Something went wrong.");
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String accessToken,
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final response = await _dio.put(
      ApiEndPoints.changePassword,
      data: {
        "old_password": oldPassword,
        "new_password": newPassword,
        "confirm_new_password": confirmNewPassword,
      },

      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
    return response.data as Map<String, dynamic>;
  }
}
