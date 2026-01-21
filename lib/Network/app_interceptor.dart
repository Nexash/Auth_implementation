import 'package:auth_implementation/LocalStorage/local_storage.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  final LocalStorage localStorage;

  AppInterceptor(this.localStorage);
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
    final String? token = await localStorage.getToken();

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
  void onError(DioException err, ErrorInterceptorHandler handler) {
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
