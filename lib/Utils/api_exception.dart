import 'dart:developer';

import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioException.connectionTimeout:
        log("connection timeout");
        return ApiException("Connection timeout.");
      case DioExceptionType.receiveTimeout:
        log("server not responding");
        return ApiException("server not responding.");
      case DioExceptionType.badResponse:
        log(error.response?.data["message"] ?? 'Server error.');
        return ApiException(error.response?.data["message"] ?? 'Server error');
      default:
        log('Unexpected error occured');
        return ApiException("Can't connect to server.");
    }
  }
}
