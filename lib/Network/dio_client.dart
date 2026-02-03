import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/Controller/password_controller.dart';
import 'package:auth_implementation/Network/app_interceptor.dart';
import 'package:auth_implementation/Utils/LocalStorage/local_storage.dart';
import 'package:auth_implementation/Utils/API_Utils/api_end_points.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient._(this.dio);
  factory DioClient(LocalStorage localStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,

        //this will not let any status below 500 show exceptions
        // validateStatus: (status) => status != null && status < 500,
        receiveDataWhenStatusError: true,
      ),
    );
    dio.interceptors.add(AppInterceptor(localStorage, dio));

    return DioClient._(dio);
  }
  void setPasswordController(PasswordController passwordController) {
    // Find the AppInterceptor and set the controller
    for (var interceptor in dio.interceptors) {
      if (interceptor is AppInterceptor) {
        interceptor.passwordController = passwordController;
      }
    }
  }

  void setAuthController(AuthController authController) {
    // Find the AppInterceptor and set the controller
    for (var interceptor in dio.interceptors) {
      if (interceptor is AppInterceptor) {
        interceptor.authController = authController;
      }
    }
  }
}
