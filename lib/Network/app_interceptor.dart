import 'dart:developer';

import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/UI/Login_Register/login/login_screen.dart';
import 'package:auth_implementation/Utils/LocalStorage/local_storage.dart';
import 'package:auth_implementation/Utils/API_Utils/api_end_points.dart';
import 'package:auth_implementation/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppInterceptor extends Interceptor {
  final Dio dio;
  final LocalStorage localStorage;
  AuthController? authController;

  AppInterceptor(this.localStorage, this.dio);
  bool _isRefreshing = false;
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final bool requiresToken =
        options.extra['requiresToken'] ?? true; // default: true
    if (!requiresToken) {
      handler.next(options);
      return;
    }
    final String? token = localStorage.getToken();

    // Add header only if token exists
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    //logging
    print('Request');
    print('URL:${options.uri}');
    print('Methods:${options.method}');
    print('Headers:${options.headers}');
    print('body:${options.data}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("Response-------");
    print('Status: ${response.statusCode}');
    print('Data:${response.data}');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // err.requestOptions it stores
    // URL / path (/api/user/profile)
    // HTTP method (GET/POST/etc.)
    // Headers (Authorization, Content-Type, etc.)
    // Body / query params
    // Extra metadata (like requiresToken)

    final requireToken = err.requestOptions.extra['requiresToken'] ?? true;
    if (err.response?.statusCode == 401 &&
        requireToken &&
        err.requestOptions.path != ApiEndPoints.getnewToken &&
        !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refreshToken = localStorage.getRefreshToken();
        final response = await dio.post(
          ApiEndPoints.getnewToken,
          data: {"refresh": refreshToken},
          options: Options(extra: {'requiresToken': false}),
        );
        if (response.statusCode == 200) {
          log("----------This is refresh token success");
          log("${response.data}");
        } else {
          log("cant gey refresh and access token.");
        }
        final newAccessToken = response.data["access"];
        final newRefreshToken = response.data["refresh"];

        await localStorage.saveToken(newAccessToken);
        await localStorage.saveRefreshToken(newRefreshToken);

        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        _isRefreshing = false;

        final retryResponse = await dio.fetch(requestOptions);
        handler.resolve(retryResponse);
        return;
      } catch (e) {
        // authController?.logout();
        log('********${authController?.errorMessage}');
        if (navigatorKey.currentState != null) {
          navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false,
          );
        }
        _isRefreshing = false;

        handler.reject(err);
        return;
      }
    }

    print("Errrorrrr------");
    print("Message: ${err.message}");
    print("Status: ${err.response?.statusCode}");
    print("data:${err.response?.data}");

    if (err.response?.statusCode == 401) {
      print("unauthorized - Refresh token here");
    }
    handler.next(err);
  }
}
