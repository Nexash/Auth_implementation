import 'package:auth_implementation/Service/api_name_service.dart';
import 'package:auth_implementation/Network/app_interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      //base url
      baseUrl: ApiEndPoints.baseUrl,

      // Timeouts
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),

      // Defailt headers
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      //reponse config
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,

      //Accept status<500
      validateStatus: (status) {
        return status != null && status < 500;
      },

      receiveDataWhenStatusError: true,
    ),
  )..interceptors.add(AppInterceptor());
}
