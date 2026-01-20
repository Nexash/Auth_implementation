import 'package:auth_implementation/Service/api_name_service.dart';
import 'package:auth_implementation/Modal/Login/login_modal.dart';
import 'package:auth_implementation/Modal/Register/register_modal.dart';
import 'package:auth_implementation/Network/dio_client.dart';
import 'package:auth_implementation/Utils/api_exception.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = DioClient.dio;

  // LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final loginData = LoginModal(email: email, password: password);
      final response = await _dio.post(
        ApiEndPoints.login,
        data: loginData.toJson(),
      );

      //--------------------- Print API response here
      print("Login API Response: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
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
