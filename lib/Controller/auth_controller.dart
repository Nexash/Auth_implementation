import 'dart:developer';

import 'package:auth_implementation/Modal/Login/Response/get_userdata_modal.dart';
import 'package:auth_implementation/Modal/Login/Response/login_response_modal.dart';
import 'package:auth_implementation/Service/auth_services.dart';
import 'package:auth_implementation/Utils/LocalStorage/local_storage.dart';
import 'package:auth_implementation/Utils/API_Utils/api_exception.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;
  final LocalStorage _localStorage;
  LocalStorage get localStorage => _localStorage;
  bool isLoading = false;
  UserData? userdata;
  String? errorMessage;

  AuthController(this._authService, this._localStorage);

  Future<bool> login({required String email, required String password}) async {
    try {
      final response = await _authService.login(email, password);

      final loginResponse = LoginResponseModal.fromJson(response);

      await _localStorage.saveToken(loginResponse.tokens.accessToken);
      await _localStorage.saveRefreshToken(loginResponse.tokens.refreshToken);

      await _localStorage.saveUser(loginResponse.user);

      await _localStorage.setLoggedIn(true);

      // Debug prints
      print("Access Token: ${loginResponse.tokens.accessToken}");
      print("Refresh Token: ${loginResponse.tokens.refreshToken}");
      print("User Info: ${loginResponse.user.toJson()}");

      return true;
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      } else {
        throw 'Something went wrong';
      }
    }
  }

  Future<void> getUserData() async {
    final token = localStorage.getToken();
    if (token == null) throw 'No token found';
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final response = await _authService.userData(token);
      final userJson = response['user'] as Map<String, dynamic>;
      userdata = UserData.fromJson(userJson);
    } catch (e) {
      if (e is ApiException) {
        log(e.message.toString());
        errorMessage = e.message;
      } else {
        log("unknown error : $e");

        errorMessage = "Something went wrong";
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkLogin() async {
    return _localStorage.isLoggedIn();
  }

  void logout() {
    _localStorage.clearAll();
    notifyListeners();
  }
}
