import 'package:auth_implementation/Controller/auth_controller.dart';
import 'package:auth_implementation/Service/auth_services.dart';
import 'package:dio/dio.dart';

import 'fake_storage.dart';

class FakeAuthController extends AuthController {
  FakeAuthController() : super(FakeAuthService(), FakeLocalStorage());
}

class FakeAuthService extends AuthService {
  FakeAuthService() : super(Dio());

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    return {
      'tokens': {
        'access-token': 'fake-access',
        'refresh-token': 'fake-refresh',
      },
    };
  }
}
