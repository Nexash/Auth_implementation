import 'dart:developer';

import 'package:auth_implementation/Modal/Login/Request/login_modal.dart';
import 'package:auth_implementation/Modal/Register/register_modal.dart';
import 'package:auth_implementation/Utils/api_end_points.dart';
import 'package:auth_implementation/Utils/api_exception.dart';
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

      switch (response.statusCode) {
        case 200:
        case 201:
          return response.data;

        case 400:
          throw ApiException(
            response.data['Error'][0] ?? 'Invalid Credentials',
          );
        case 401:
          throw ApiException(response.data['Error'][0] ?? 'Unauthorized');

        default:
          throw ApiException("Something went wrong.");
      }
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException("Something went wrong.");
    }
  }

  // REGISTER
  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
    String confirmPassword,
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
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
