import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioException.connectionTimeout:
        return ApiException("connection timeout");
      case DioExceptionType.receiveTimeout:
        return ApiException("server not responding");
      case DioExceptionType.badResponse:
        return ApiException(error.response?.data["message"] ?? 'server error');
      default:
        return ApiException('Unexpected error occured');
    }
  }
}
