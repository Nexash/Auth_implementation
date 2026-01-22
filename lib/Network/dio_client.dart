import 'package:auth_implementation/Network/app_interceptor.dart';
import 'package:auth_implementation/Utils/LocalStorage/local_storage.dart';
import 'package:auth_implementation/Utils/api_end_points.dart';
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
    dio.interceptors.add(AppInterceptor(localStorage));

    return DioClient._(dio);
  }
}
